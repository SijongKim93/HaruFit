//
//  UserSession.swift
//  DepsChat
//
//  Created by SiJongKim on 3/10/25.
//

import Foundation

public struct UserSession: Equatable, Codable {
    public let userId: UUID
    public let nickname: String
    public let proflieImageData: Data?
    public let gender: String
    public let ageGroup: String
    public let isLoggedIn: Bool

    public init(userId: UUID, nickname: String, profileImageData: Data, gender: String, ageGroup: String, isLoggedIn: Bool) {
        self.userId = userId
        self.nickname = nickname
        self.proflieImageData = profileImageData
        self.gender = gender
        self.ageGroup = ageGroup
        self.isLoggedIn = isLoggedIn
    }
}
