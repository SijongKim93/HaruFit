//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//

import Foundation

public protocol WorkoutRecordRepository {
    @MainActor func getRecords(for date: Date) async -> [WorksoutRecord]
    @MainActor func addRecord(_ record: WorksoutRecord) async
    @MainActor func deleteRecord(_ record: WorksoutRecord) async
}
