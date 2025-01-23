//
//  UserSession.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import Foundation

struct UserSession: Equatable {
    let userId: String
    let nickname: String?
    let proflieImageData: Data?
    
    let isLoggedIn: Bool
}
