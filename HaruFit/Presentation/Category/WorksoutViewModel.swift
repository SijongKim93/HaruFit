//
//  WorksoutViewModel.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI
import Combine

final class WorksoutViewModel: ObservableObject {
    @Published var selectedWorkout: WorkoutType = .weightTraining
    @Published var todayRecords: [WorkoutRecord] = []

    private let fetchTodayRecordsUseCase: FetchTodayRecordsUseCase
    private let addRecordUseCase: AddRecordUseCase
    private var cancellables: Set<AnyCancellable> = []

    init(fetchTodayRecordsUseCase: FetchTodayRecordsUseCase, addRecordUseCase: AddRecordUseCase) {
        self.fetchTodayRecordsUseCase = fetchTodayRecordsUseCase
        self.addRecordUseCase = addRecordUseCase

        loadTodayRecords()
    }

    func loadTodayRecords() {
        let today = Date().startOfDay
        todayRecords = fetchTodayRecordsUseCase.execute(today: today)
    }

    func addRecord(exerciseName: String) {
        let record = WorkoutRecord(
            date: Date(),
            workoutType: selectedWorkout,
            exerciseName: exerciseName
        )
        addRecordUseCase.execute(record: record)
        loadTodayRecords()
    }
}
