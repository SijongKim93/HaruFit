//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public protocol FetchWorkoutRecordUseCase {
    @MainActor func execute(for date: Date) async -> [WorksoutRecord]
}
