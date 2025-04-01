//
//  File.swift
//  Worksout
//
//  Created by SiJongKim on 4/1/25.
//
import SwiftData
import Foundation

public final class SwiftDataWorkoutRepository: WorkoutRecordRepository {
    private let modelContainer: ModelContainer

    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }

    @MainActor
    public func getRecords(for date: Date) async -> [WorksoutRecord] {
        let context = modelContainer.mainContext
        let startOfDay = Calendar.current.startOfDay(for: date)
        guard let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else { return [] }

        let predicate = #Predicate<WorksoutRecord> { record in
            record.date >= startOfDay && record.date < endOfDay
        }

        let fetchDescriptor = FetchDescriptor<WorksoutRecord>(predicate: predicate)

        do {
            let records = try context.fetch(fetchDescriptor)
            return records
        } catch {
            print("Error fetching records: \(error)")
            return []
        }
    }

    @MainActor
    public func addRecord(_ record: WorksoutRecord) async {
        let context = modelContainer.mainContext
        context.insert(record)
        do {
            try context.save()
        } catch {
            print("Error saving record: \(error)")
        }
    }

    @MainActor
    public func deleteRecord(_ record: WorksoutRecord) async {
        let context = modelContainer.mainContext
        context.delete(record)
        do {
            try context.save()
        } catch {
            print("Error deleting record: \(error)")
        }
    }
}
