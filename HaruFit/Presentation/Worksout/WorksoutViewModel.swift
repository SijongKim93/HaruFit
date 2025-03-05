//
//  WorksoutViewModel.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI
import SwiftData

@MainActor
final class WorksoutViewModel: ObservableObject {
    @Published var todayRecords: [WorkoutRecord] = []
    @Published var selectedWorkout: WorkoutType = .weightTraining

    private let fetchTodayRecordUseCase: FetchWorkoutRecordUseCase
    private let addRecordUseCase: AddWorkRecordUseCase

    init(fetchTodayRecordUseCase: FetchWorkoutRecordUseCase, addRecordUseCase: AddWorkRecordUseCase) {
        self.fetchTodayRecordUseCase = fetchTodayRecordUseCase
        self.addRecordUseCase = addRecordUseCase
    }

    func loadTodayRecords() {
        Task {
            let today = Date().startOfDay
            todayRecords = await fetchTodayRecordUseCase.execute(for: today)
        }
    }

    func addRecord(exerciseName: String) {
        Task {
            let record = WorkoutRecord(
                date: Date(),
                workoutType: String(describing: selectedWorkout),
                exerciseName: exerciseName
            )
            await addRecordUseCase.execute(workRecord: record)
            loadTodayRecords()
        }
    }
}
