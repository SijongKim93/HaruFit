//
//  AddWorkRecordUseCase.swift
//  HaruFit
//
//  Created by SiJongKim on 3/5/25.
//

import Foundation

protocol AddWorkRecordUseCase {
    func execute(workRecord: WorkoutRecord) async
}

final class DefaultAddWorkRecordUseCase: AddWorkRecordUseCase {
    private let repsoitory: WorkoutRecordRepository

    init(repsoitory: WorkoutRecordRepository) {
        self.repsoitory = repsoitory
    }

    func execute(workRecord: WorkoutRecord) async {
        await repsoitory.addRecord(workRecord)
    }
}
