//
//  FetchTodayRecordsUseCase.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

protocol FetchTodayRecordsUseCase {
    func execute(today: Date) -> [WorkoutRecord]
}

final class DefaultFetchTodayRecordsUseCase: FetchTodayRecordsUseCase {
    private let repository: WorkoutRecordRepository

    init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    func execute(today: Date) -> [WorkoutRecord] {
        return repository.getRecords(for: today)
    }
}
