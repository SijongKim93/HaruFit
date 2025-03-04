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
    var id: UUID = UUID()
    var date: Date
    var workoutType: String
    var exerciseName: String

    init(date: Date, workoutType: String, exerciseName: String) {
        self.date = date
        self.workoutType = workoutType
        self.exerciseName = exerciseName
    }
}
