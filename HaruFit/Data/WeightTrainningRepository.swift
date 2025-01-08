//
//  WeightTrainningRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

protocol WeightTrainingRepository {
    func saveWeightData(setting: WeightTraining)
    func loadWeightData() -> WeightTraining?
}

final class DefaultWeightTrainingRepository: WeightTrainingRepository {
    private var storedWeightData: WeightTraining?
    
    func saveWeightData(setting: WeightTraining) {
        storedWeightData = setting
    }
    
    func loadWeightData() -> WeightTraining? {
        storedWeightData
    }
}
