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
    private let deleteRecordUseCase: DeleteWorkoutRecordUseCase

    init(fetchTodayRecordUseCase: FetchWorkoutRecordUseCase, addRecordUseCase: AddWorkRecordUseCase, deleteRecordUseCase: DeleteWorkoutRecordUseCase) {
        self.fetchTodayRecordUseCase = fetchTodayRecordUseCase
        self.addRecordUseCase = addRecordUseCase
        self.deleteRecordUseCase = deleteRecordUseCase
    }

    func loadTodayRecords() {
        Task {
            let today = Date().startOfDay
            todayRecords = await fetchTodayRecordUseCase.execute(for: today)
        }
    }

    func addRecord(exerciseName: String, setCountText: String, repCountText: String) {
        guard !exerciseName.isEmpty,
              let setCount = Int(setCountText), setCount > 0,
              let repCount = Int(repCountText), repCount > 0 else {
            
            return
        }

        Task {
            let record = WorkoutRecord(
                date: Date(),
                workoutType: String(describing: selectedWorkout),
                exerciseName: exerciseName,
                setCount: setCount,
                repCount: repCount
            )
            await addRecordUseCase.execute(workRecord: record)
            loadTodayRecords()  // await 추가
        }
    }

    func deleteRecord(record: WorkoutRecord) {
        Task {
            await deleteRecordUseCase.execute(workRecord: record)
            loadTodayRecords()
        }
    }
}
