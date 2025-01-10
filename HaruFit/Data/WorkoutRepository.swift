//
//  WorkoutRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/10/25.
//

import Foundation

protocol WorkoutRepository {
    func saveWorkoutSetting(_ setting: WorkoutSetting)
    func loadWorkoutSetting() -> WorkoutSetting?
}

final class InMemoryWorkoutRepository: WorkoutRepository {
    private var stored: WorkoutSetting?
    
    init() {}
    
    func saveWorkoutSetting(_ setting: WorkoutSetting) {
        stored = setting
    }
    
    func loadWorkoutSetting() -> WorkoutSetting? {
        stored
    }
}
