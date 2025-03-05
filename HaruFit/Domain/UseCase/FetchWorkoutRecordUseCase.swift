//
//  FetchWorkoutRecordUseCase.swift
//  HaruFit
//
//  Created by SiJongKim on 3/5/25.
//

import Foundation

protocol FetchWorkoutRecordUseCase {
    func execute(for date: Date) async -> [WorkoutRecord]
}

final class DefaultFetchWorkoutRecordUseCase: FetchWorkoutRecordUseCase {
    private let repository: WorkoutRecordRepository

    init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    func execute(for date: Date) async -> [WorkoutRecord] {
        await repository.getRecords(for: date)
    }
}
