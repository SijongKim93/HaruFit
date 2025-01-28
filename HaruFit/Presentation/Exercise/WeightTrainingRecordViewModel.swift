//
//  WeightTrainingRecordViewModel.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import Foundation

class WeightTrainingRecordViewModel: ObservableObject {
    @Published var selectedExercises: [Exercise] = []
    private let exerciseUseCase: ExerciseUseCase
    let bodyPart: BodyPart
    
    init(bodyPart: BodyPart, exerciseUseCase: ExerciseUseCase) {
        self.bodyPart = bodyPart
        self.exerciseUseCase = exerciseUseCase
    }
    
    func availableExercises() -> [String] {
        exerciseUseCase.fetchExercises(for: bodyPart)
    }
    
    func addExercise(name: String) {
        let newExercise = Exercise(
            name: name,
            weight: 10,
            reps: 10,
            sets: 3,
            isKgUnit: true
        )
        selectedExercises.append(newExercise)
    }
}
