//
//  WorkoutRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/10/25.
//

import Foundation

protocol WorkoutRecordRepository {
    func getRecords(for date: Date) -> [WorkoutRecord]
    func addRecord(_ record: WorkoutRecord)
}

final class InMemoryWorkoutRepository: WorkoutRecordRepository {
    private var records: [WorkoutRecord] = []

    func getRecords(for date: Date) -> [WorkoutRecord] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        return records.filter {
            Calendar.current.isDate($0.date, inSameDayAs: startOfDay)
        }
    }

    func addRecord(_ record: WorkoutRecord) {
        records.append(record)
    }
}
