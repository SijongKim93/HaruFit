//
//  AddRecordUseCase.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import Foundation

protocol AddRecordUseCase {
    func execute(record: WorkoutRecord)
}

final class DefaultAddRecordUseCase: AddRecordUseCase {
    private let repository: WorkoutRecordRepository

    init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    func execute(record: WorkoutRecord) {
        repository.addRecord(record)
    }
}
