//
//  AppDIContainer.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

final class DIContainer {
    static let shared = DIContainer()

    // MARK: - Data
    lazy var workoutRepository: WorkoutRecordRepository = {
        return InMemoryWorkoutRepository()
    }()
    
    lazy var userSessionRepository: UserSessionRepository = {
        return AppStorageUserSessionRepository()
    }()

    // MARK: - Use Cases
    lazy var userSessionUseCase: UserSessionUseCase = {
        DefaultUserSessionUseCase(repository: userSessionRepository)
    }()
    
    // MARK: - View Model
    func makeUserInfoViewModel() -> UserInfoViewModel {
        UserInfoViewModel(userSessionUseCase: userSessionUseCase)
    }
}
