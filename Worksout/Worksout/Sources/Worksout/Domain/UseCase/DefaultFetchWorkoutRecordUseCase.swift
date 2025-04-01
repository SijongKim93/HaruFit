//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public final class DefaultFetchWorkoutRecordUseCase: FetchWorkoutRecordUseCase {
    private let repository: WorkoutRecordRepository

    public init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    @MainActor
    public func execute(for date: Date) async -> [WorksoutRecord] {
        await repository.getRecords(for: date)
    }
}
