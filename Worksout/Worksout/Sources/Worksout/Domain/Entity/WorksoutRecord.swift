import Foundation
import SwiftData

@Model
public final class WorksoutRecord {
    @Attribute(.unique) public var id: UUID = UUID()
    public var date: Date
    public var workoutType: String
    public var exerciseName: String
    public var setCount: Int
    public var repCount: Int

    public init(date: Date, workoutType: String, exerciseName: String, setCount: Int, repCount: Int) {
        self.date = date
        self.workoutType = workoutType
        self.exerciseName = exerciseName
        self.setCount = setCount
        self.repCount = repCount
    }
}
