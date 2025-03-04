// Data/Repositories/InMemoryExerciseRecordRepository.swift

final class ExerciseMemoryRepository: ExerciseRecordRepository {
    private var records: [ExerciseRecord] = []

    func save(_ record: ExerciseRecord) {
        records.append(record)
    }
    
    func fetchConsecutiveDaysCount() -> Int {

        return 3
    }
    
    func fetchTotalRecordCount() -> Int {
        records.count
    }
}
