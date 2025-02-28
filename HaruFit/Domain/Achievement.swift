//
//  Achievement.swift
//  HaruFit
//
//  Created by 김시종 on 3/1/25.
//

import Foundation

struct Achievement: Equatable, Identifiable {
    let id: String
    let name: String
    let description: String
    let iconName: String
    
    var isUnlocked: Bool
}
