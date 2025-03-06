//
//  WorkoutRecord.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import Foundation
import SwiftData

@Model
final class WorkoutRecord {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var workoutType: String
    var exerciseName: String
    var setCount: Int
    var repCount: Int

    init(date: Date, workoutType: String, exerciseName: String, setCount: Int, repCount: Int) {
        self.date = date
        self.workoutType = workoutType
        self.exerciseName = exerciseName
        self.setCount = setCount
        self.repCount = repCount
    }
}
