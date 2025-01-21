//
//  WeightTrainingViewModel.swift
//  HaruFit
//
//  Created by 김시종 on 1/21/25.
//

import SwiftUI
import Combine

class WeightTrainingViewModel: ObservableObject {
    @Published var restTime: Int = 120
    @Published var totalSets: Int = 5
    @Published var currentSets: Int = 0
    @Published var remainingTime: Int = 60
    
    @Published var timerFraction: CGFloat = 1.0
    
    private var workoutUseCase: WorkoutUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var initialRestTime: Int = 60
    private let refreshTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(useCase: WorkoutUseCase) {
        self.workoutUseCase = useCase
        
        setupTimerRefresh()
    }
    
    func onAppear() {
        if let saved = workoutUseCase.loadSetting() {
            if saved.workoutType == .weightTraining {
                restTime = saved.restTime ?? 120
                totalSets = saved.totalSets ?? 5
                currentSets = saved.currentSets ?? 0
                remainingTime = saved.restTime ?? 60
                initialRestTime = saved.restTime ?? 60
                
            }
        }
    }
    
    func start() {
        let setting = WorkoutSetting(
            workoutType: .weightTraining,
            restTime: restTime,
            totalSets: totalSets,
            currentSets: currentSets,
            distance: 0,
            runningTime: 0
        )
        workoutUseCase.startWorkout(setting: setting)
        
        remainingTime = restTime
        initialRestTime = restTime
        currentSets = 0
        
        updateFraction()
    }
    
    func stop() {
        workoutUseCase.stopWorkout()
    }
    
    func updateRestTime(_ time: Int) {
        restTime = time
    }
    
    func updateTotalSets(_ sets: Int) {
        totalSets = sets
    }
    
    private func setupTimerRefresh() {
        refreshTimer
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.refreshFromUseCase()
            }
            .store(in: &cancellables)
    }
    
    private func refreshFromUseCase() {
        guard let current = workoutUseCase.loadSetting() else { return }
        
        if current.workoutType == .weightTraining {
            self.remainingTime = current.restTime ?? restTime
            self.currentSets = current.currentSets ?? 0
            
            updateFraction()
        }
    }
    
    private func updateFraction() {
        if initialRestTime > 0 {
            self.timerFraction = CGFloat(remainingTime) / CGFloat(initialRestTime)
        } else {
            self.timerFraction = 0
        }
    }
}
