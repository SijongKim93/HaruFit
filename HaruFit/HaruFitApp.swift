//
//  HaruFitApp.swift
//  HaruFit
//
//  Created by 김시종 on 1/7/25.
//

import SwiftUI

@main
struct HaruFitApp: App {
    // 1) 의존성 준비
    private let userSessionRepo = AppStorageUserSessionRepository()
    private let userSessionUseCase: UserSessionUseCase
    
    // 2) UserInfoViewModel 준비
    private let userInfoViewModel: UserInfoViewModel
    
    init() {
        self.userSessionUseCase = DefaultUserSessionUseCase(repository: userSessionRepo)
        // UserInfoViewModel을 생성할 때, userSessionUseCase를 주입
        self.userInfoViewModel = UserInfoViewModel(userSessionUseCase: userSessionUseCase)
    }
    
    var body: some Scene {
        WindowGroup {
            UserInfoView(viewModel: userInfoViewModel)
        }
    }
}
