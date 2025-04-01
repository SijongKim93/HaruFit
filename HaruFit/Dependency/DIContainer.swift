//
//  AppDIContainer.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI
import SwiftData
import UserSession
import Worksout

final class DIContainer {
    static let shared = DIContainer()

    lazy var modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: WorksoutRecord.self)
        } catch {
            fatalError("Could not create ModelContainer")
        }
    }()

    // MARK: - Data    
    lazy var userSessionRepository: UserSessionRepository = {
        return AppStorageUserSessionRepository()
    }()

    lazy var workoutRecordRepository: WorkoutRecordRepository = {
        return SwiftDataWorkoutRepository(modelContainer: modelContainer)
    }()

    // MARK: - Use Cases
    lazy var userSessionUseCase: UserSessionUseCase = {
        DefaultUserSessionUseCase(repository: userSessionRepository)
    }()

    lazy var fetchWorkoutRecordsUseCase: FetchWorkoutRecordUseCase = {
        DefaultFetchWorkoutRecordUseCase(repository: workoutRecordRepository)
    }()

    lazy var addWorkoutRecordUseCase: AddWorkRecordUseCase = {
        DefaultAddWorkRecordUseCase(repository: workoutRecordRepository)
    }()

    lazy var deleteWorkoutRecordUseCase: DeleteWorkoutRecordUseCase = {
        DefaultDeleteWorkoutRecordUseCase(repository: workoutRecordRepository)
    }()

    // MARK: - View Model
    func makeUserInfoViewModel() -> UserSessionViewModel {
        UserSessionViewModel(userSessionUseCase: userSessionUseCase)
    }

    @MainActor
    func makeWorksoutViewModel() -> WorksoutViewModel {
        WorksoutViewModel(
            fetchTodayRecordUseCase: fetchWorkoutRecordsUseCase,
            addRecordUseCase: addWorkoutRecordUseCase,
            deleteRecordUseCase: deleteWorkoutRecordUseCase
        )
    }
}
