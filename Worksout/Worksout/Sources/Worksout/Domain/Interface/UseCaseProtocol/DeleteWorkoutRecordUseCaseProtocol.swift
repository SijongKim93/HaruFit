//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public protocol DeleteWorkoutRecordUseCase {
    @MainActor func execute(worksRecord: WorksoutRecord) async
}
