//
//  Workout.swift
//  HaruFit
//
//  Created by 김시종 on 1/10/25.
//

import Foundation

public enum Workout {
    case weightTraining
    case running
    case tabata
}

public struct WorkoutSetting {
    let workoutType: Workout
    
    // 웨이트 트레이닝
    let restTime: Int?
    let totalSets: Int?
    let currentSets: Int?
    
    // 런닝
    let distance: Double
    let runningTime: Int
    
    public init(workoutType: Workout, restTime: Int?, totalSets: Int?, currentSets: Int?, distance: Double, runningTime: Int) {
        self.workoutType = workoutType
        self.restTime = restTime
        self.totalSets = totalSets
        self.currentSets = currentSets
        self.distance = distance
        self.runningTime = runningTime
    }
}
