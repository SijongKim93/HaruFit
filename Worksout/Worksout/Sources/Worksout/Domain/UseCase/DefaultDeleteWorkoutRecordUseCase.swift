//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public final class DefaultDeleteWorkoutRecordUseCase: DeleteWorkoutRecordUseCase {
    private let repository: WorkoutRecordRepository

    public init(repository: WorkoutRecordRepository) {
        self.repository = repository
    }

    @MainActor
    public func execute(worksRecord: WorksoutRecord) async {
        await repository.deleteRecord(worksRecord)
    }
}
