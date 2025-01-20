//
//  WorkoutUseCase.swift
//  HaruFit
//
//  Created by 김시종 on 1/10/25.
//

import SwiftUI
import Combine

protocol WorkoutUseCase {
    func startWorkout(setting: WorkoutSetting)
    func stopWorkout()
    func updateSetting(_ setting: WorkoutSetting)
    func loadSetting() -> WorkoutSetting?
}

final class DefaultWorkoutUseCase: WorkoutUseCase {
    private let repository: WorkoutRepository
    private var timer: Timer?
    private var currentSetting: WorkoutSetting?
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func startWorkout(setting: WorkoutSetting) {
        repository.saveWorkoutSetting(setting)
        currentSetting = setting
        
        switch setting.workoutType {
        case .weightTraining:
            startWeightTraining(setting)
        case .running:
            startRunning(setting)
        case .tabata:
            startRunning(setting)
        case .yoga:
            break
        }
        
    }
    
    func stopWorkout() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateSetting(_ setting: WorkoutSetting) {
        repository.saveWorkoutSetting(setting)
        currentSetting = setting
    }
    
    func loadSetting() -> WorkoutSetting? {
        let saved = repository.loadWorkoutSetting()
        currentSetting = saved
        return saved
    }
    
    private func startWeightTraining(_ setting: WorkoutSetting) {
        guard let restTime = setting.restTime,
              let totalSets = setting.totalSets else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  var current = self.currentSetting else { return }
            
            if (current.restTime ?? 0) > 0 {
                let newRest = (current.restTime ?? 0) - 1
                current = WorkoutSetting(
                    workoutType: .weightTraining,
                    restTime: newRest,
                    totalSets: current.totalSets,
                    currentSets: current.currentSets,
                    distance: current.distance,
                    runningTime: current.runningTime
                )
                self.currentSetting = current
            } else {
                let doneSets = (current.currentSets ?? 0) + 1
                if doneSets > totalSets {
                    self.stopWorkout()
                } else {
                    current = WorkoutSetting(
                        workoutType: .weightTraining,
                        restTime: restTime,
                        totalSets: totalSets,
                        currentSets: doneSets,
                        distance: current.distance,
                        runningTime: current.runningTime
                    )
                    self.currentSetting = current
                }
            }
        }
    }
    
    private func startRunning(_ setting: WorkoutSetting) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  var current = self.currentSetting else { return }
            
            let newRunningTime = current.runningTime + 1
            current = WorkoutSetting(
                workoutType: .running,
                restTime: current.restTime,
                totalSets: current.totalSets,
                currentSets: current.currentSets,
                distance: current.distance,
                runningTime: newRunningTime
            )
            self.currentSetting = current
        }
    }
}
