//
//  User.swift
//  HaruFit
//
//  Created by 김시종 on 1/18/25.
//

import Foundation

enum SocialProvider {
    case apple
    case google
    case kakao
    case naver
}

struct User {
    let userId: String
    let name: String?
    let email: String?
    let profileImageUrl: String?
    let socialProvider: SocialProvider?
    
    let isLoggined: Bool
    
    init(userId: String, 
         name: String? = nil,
         email: String? = nil,
         profileImageUrl: String? = nil,
         socialProvider: SocialProvider? = nil,
         isLoggined: Bool = false) 
    {
        self.userId = userId
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.socialProvider = socialProvider
        self.isLoggined = isLoggined
    }
}
