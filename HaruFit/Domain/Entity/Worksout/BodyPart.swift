//
//  BodyPart.swift
//  HaruFit
//
//  Created by 김시종 on 1/22/25.
//

import Foundation

enum BodyPart: CaseIterable {
    case back
    case chest
    case shoulder
    case lowerBody
    case fullBody
    case core
    
    var title: String {
        switch self {
        case .back:
            return "등"
        case .chest:
            return "가슴"
        case .shoulder:
            return "어깨"
        case .lowerBody:
            return "하체"
        case .fullBody:
            return "전신"
        case .core:
            return "코어"
        }
    }
}
