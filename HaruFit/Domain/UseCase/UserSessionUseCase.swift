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
        ageGroup: String,
        nickname: String,
        profileImageData: Data?
    ) -> UserSession
    func logout()
    func currentSession() -> UserSession?
    
    // 입력 유효성 검사 메서드들
    func validateNickname(_ nickname: String) -> Bool
    func validateGender(_ gender: String) -> Bool
    func validateAgeGroup(_ ageGroup: String) -> Bool
}

class DefaultUserSessionUseCase: UserSessionUseCase {
    private let repository: UserSessionRepository
    
    init(repository: UserSessionRepository) {
        self.repository = repository
    }
    
    func login(
        userId: String,
        gender: String,
        ageGroup: String,
        nickname: String,
        profileImageData: Data?
    ) -> UserSession {
        let newSession = UserSession(
            userId: userId,
            nickname: nickname,
            proflieImageData: profileImageData,
            gender: gender,
            ageGroup: ageGroup,
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
    
    // 입력 유효성 검사
    func validateNickname(_ nickname: String) -> Bool {
        return nickname.count >= 2
    }
    
    func validateGender(_ gender: String) -> Bool {
        return !gender.isEmpty
    }
    
    func validateAgeGroup(_ ageGroup: String) -> Bool {
        return !ageGroup.isEmpty
    }
}
