//
//  HaruFitApp.swift
//  HaruFit
//
//  Created by 김시종 on 1/7/25.
//

import SwiftUI

@main
struct HaruFitApp: App {
    // 의존성 준비
    private let userSessionRepo = AppStorageUserSessionRepository()
    private let userSessionUseCase: UserSessionUseCase
    
    init() {
        self.userSessionUseCase = DefaultUserSessionUseCase(repository: userSessionRepo)
    }
    
    var body: some Scene {
        WindowGroup {
            RouteTabView()
        }
    }
}
