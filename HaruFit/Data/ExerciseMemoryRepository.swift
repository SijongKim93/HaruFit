// Data/Repositories/InMemoryExerciseRecordRepository.swift

final class ExerciseMemoryRepository: ExerciseRecordRepository {
    private var records: [ExerciseRecord] = []
    
    func save(_ record: ExerciseRecord) {
        records.append(record)
    }
    
    func fetchConsecutiveDaysCount() -> Int {
        // 예: records를 날짜 순으로 정렬, 가장 최근 날짜부터 역순으로 연속 일수 계산
        // 여기서는 단순 예시
        return 3
    }
    
    func fetchTotalRecordCount() -> Int {
        records.count
    }
}
