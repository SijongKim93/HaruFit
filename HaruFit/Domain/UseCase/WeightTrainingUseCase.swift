//
//  WeightTrainingUseCase.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI
import Combine

protocol WeightTrainingUseCase {
    func startWeight(setting: WeightTraining)
    func stopWeight()
}

final class DefaultWeightTrainingUseCase: WeightTrainingUseCase {
    private let repository: WeightTrainingRepository
    
    private var currentSet: Int = 0
    private var remainingRestTime: Int = 0
    private var timer: Timer?
    
    init(repository: WeightTrainingRepository) {
        self.repository = repository
    }
    
    func startWeight(setting: WeightTraining) {
        repository.saveWeightData(setting: setting)
        
        currentSet = 1
        remainingRestTime = setting.resetTime
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.onTick(setting: setting)
        }
    }
    
    func stopWeight() {
        timer?.invalidate()
        timer = nil
    }
    
    private func onTick(setting: WeightTraining) {
        guard currentSet <= setting.totalSets else {
            stopWeight()
            return
        }
        
        if remainingRestTime > 0 {
            remainingRestTime -= 1
        } else {
            currentSet += 1
            remainingRestTime = setting.resetTime
        }
    }
}
