//
//  ExerciseRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import Foundation

protocol ExerciseRepository {
    func getExercises(for bodyPart: BodyPart) -> [String]
}

class DefaultExerciseRepository: ExerciseRepository {
    func getExercises(for bodyPart: BodyPart) -> [String] {
        ExerciseResource.exercises(for: bodyPart)
    }
}
