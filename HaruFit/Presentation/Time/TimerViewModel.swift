//
//  TimerViewModel.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI
import Combine

final class TimerViewModel: ObservableObject {
    @Published var workoutType: Workout = .weightTraining
    @Published var restTime: Int = 60
    @Published var totalSets: Int = 5
    @Published var currentSets: Int = 0
    @Published var distance: Double = 5.0
    @Published var runningTime: Int = 0
    
    private let useCase: WorkoutUseCase
    
    init(useCase: WorkoutUseCase) {
        self.useCase = useCase
    }
    
    func onAppear() {
        if let saved = useCase.loadSetting() {
            workoutType = saved.workoutType
            restTime = saved.restTime ?? 60
            totalSets = saved.totalSets ?? 5
            currentSets = saved.currentSets ?? 0
            distance = saved.distance
            runningTime = saved.runningTime
        }
    }
    
    func start() {
        let setting = WorkoutSetting(
            workoutType: workoutType,
            restTime: restTime,
            totalSets: totalSets,
            currentSets: currentSets,
            distance: distance,
            runningTime: runningTime
        )
        useCase.startWorkout(setting: setting)
    }
    
    func stop() {
        useCase.stopWorkout()
    }
    
    func saveSetting() {
        let setting = WorkoutSetting(
            workoutType: workoutType,
            restTime: restTime,
            totalSets: totalSets,
            currentSets: currentSets,
            distance: distance,
            runningTime: runningTime
        )
        useCase.updateSetting(setting)
    }
}
