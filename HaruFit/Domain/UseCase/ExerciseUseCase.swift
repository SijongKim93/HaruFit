//
//  ExerciseUseCase.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import Foundation

protocol ExerciseUseCase {
    func fetchExercises(for bodyPart: BodyPart) -> [String]
}

class DefaultExerciseUseCase: ExerciseUseCase {
    let repository: ExerciseRepository
    
    init(repository: ExerciseRepository) {
        self.repository = repository
    }
    
    func fetchExercises(for bodyPart: BodyPart) -> [String] {
        repository.getExercises(for: bodyPart)
    }
}
