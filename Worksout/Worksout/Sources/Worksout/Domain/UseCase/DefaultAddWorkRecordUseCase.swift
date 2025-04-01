//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public final class DefaultAddWorkRecordUseCase: AddWorkRecordUseCase {
    private let repository: WorkoutRecordRepository

    public init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    @MainActor
    public func execute(worksRecord: WorksoutRecord) async {
         await repository.addRecord(worksRecord)
    }
}
