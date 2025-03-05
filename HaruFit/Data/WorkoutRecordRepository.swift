import SwiftData
import Foundation

protocol WorkoutRecordRepository {
    func getRecords(for date: Date) async -> [WorkoutRecord]
    func addRecord(_ record: WorkoutRecord) async
}

@MainActor
final class SwiftDataWorkoutRepository: WorkoutRecordRepository {
    private let modelContainer: ModelContainer

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }

    func getRecords(for date: Date) async -> [WorkoutRecord] {
        let context = modelContainer.mainContext
        let startOfDay = Calendar.current.startOfDay(for: date)
        guard let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else { return [] }

        let predicate = #Predicate<WorkoutRecord> { record in
            record.date >= startOfDay && record.date < endOfDay
        }

        let fetchDescriptor = FetchDescriptor<WorkoutRecord>(predicate: predicate)

        do {
            let records = try context.fetch(fetchDescriptor)
            return records
        } catch {
            print("Error fetching records: \(error)")
            return []
        }
    }

    func addRecord(_ record: WorkoutRecord) async {
        let context = modelContainer.mainContext
        context.insert(record)
        do {
            try context.save()
        } catch {
            print("Error saving record: \(error)")
        }
    }
}
