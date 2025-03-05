//
//  DeleteWorkoutRecordUseCase.swift
//  HaruFit
//
//  Created by SiJongKim on 3/5/25.
//

import Foundation

protocol DeleteWorkoutRecordUseCase {
    func execute(workRecord: WorkoutRecord) async
}

final class DefaultDeleteWorkoutRecordUseCase: DeleteWorkoutRecordUseCase {
    private let repository: WorkoutRecordRepository

    init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }
    
    func execute(workRecord: WorkoutRecord) async {
        await repository.deleteRecord(workRecord)
    }
}
