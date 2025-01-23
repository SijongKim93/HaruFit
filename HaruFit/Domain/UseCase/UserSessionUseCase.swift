//
//  UserSessionUseCase.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import Foundation

protocol UserSessionUseCase {
    func login(userId: String, nickname: String?, proflileImageData: Data?) -> UserSession
    func logout()
    func currentSession() -> UserSession?
}

class DefaultUserSessionUseCase: UserSessionUseCase {
    private let repository: UserSessionRepository
    
    init(repository: UserSessionRepository) {
        self.repository = repository
    }
    
    func login(userId: String, nickname: String?, proflileImageData: Data?) -> UserSession {
        let newSession = UserSession(
            userId: userId,
            nickname: nickname,
            proflieImageData: proflileImageData,
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
