//
//  UserSessionRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import SwiftUI

protocol UserSessionRepository {
    func save(session: UserSession)
    func load() -> UserSession?
    func clear()
}

class AppStorageUserSessionRepository: UserSessionRepository {
    @AppStorage("userId") private var userId: String?
    @AppStorage("nickname") private var nickname: String?
    @AppStorage("gender") private var gender: String?
    @AppStorage("age") private var age: Int = 0
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    @AppStorage("profileImageBase64") private var profileImageBase64: String?
    
    func save(session: UserSession) {
        userId = session.userId
        nickname = session.nickname
        gender = session.gender
        age = session.age ?? 0
        isLoggedIn = session.isLoggedIn
        
        if let imageData = session.proflieImageData {
            profileImageBase64 = imageData.base64EncodedString()
        } else {
            profileImageBase64 = nil
        }
    }
    
    func load() -> UserSession? {
        guard let uid = userId, isLoggedIn else { return nil }
        
        let decodedData = profileImageBase64.flatMap { Data(base64Encoded: $0) }
        
        return UserSession(
            userId: uid,
            nickname: nickname,
            proflieImageData: decodedData,
            gender: gender,
            age: (age == 0 ? nil : age),
            isLoggedIn: isLoggedIn
        )
    }
    
    func clear() {
        userId = nil
        nickname = nil
        gender = nil
        age = 0
        isLoggedIn = false
        profileImageBase64 = nil
    }
}
