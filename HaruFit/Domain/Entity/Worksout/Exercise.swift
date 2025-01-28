//
//  Exercise.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    var weight: Int
    var reps: Int
    var sets: Int
    var isKgUnit: Bool
}
