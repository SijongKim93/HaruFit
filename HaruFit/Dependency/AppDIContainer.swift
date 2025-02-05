//
//  AppDIContainer.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

final class AppDIContainer {
    static let shared = AppDIContainer()

    // MARK: - Data
    lazy var workoutRepository: WorkoutRecordRepository = {
        return InMemoryWorkoutRepository()
    }()
    

    // MARK: - Use Cases

}
