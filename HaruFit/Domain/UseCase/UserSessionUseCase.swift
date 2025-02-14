//
//  UserSessionUseCase.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import Foundation

protocol UserSessionUseCase {
    func login(
        userId: String,
        gender: String,
        age: Int,
        nickname: String,
        profileImageData: Data?) -> UserSession
    func logout()
    func currentSession() -> UserSession?
}

class DefaultUserSessionUseCase: UserSessionUseCase {
    private let repository: UserSessionRepository
    
    init(repository: UserSessionRepository) {
        self.repository = repository
    }
    
    func login(
        userId: String,
        gender: String,
        age: Int,
        nickname: String,
        profileImageData: Data?) -> UserSession 
    {
        let newSession = UserSession(
            userId: userId,
            nickname: nickname,
            proflieImageData: profileImageData,
            gender: gender,
            age: age,
            isLoggedIn: true
        )
        repository.save(session: newSession)
        return newSession
    }
    
    func logout() {
        repository.clear()
    }
    
    func currentSession() -> UserSession? {
        repository.load()
    }
}
