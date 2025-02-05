//
//  WorkoutRecord.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import Foundation

struct WorkoutRecord: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let workoutType: WorkoutType
    let exerciseName: String
}
