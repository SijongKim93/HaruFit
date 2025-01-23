//
//  UserSessionRepository.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import Foundation

protocol UserSessionRepository {
    func save(session: UserSession)
    func load() -> UserSession?
    func clear()
}
