//
//  HaruFitApp.swift
//  HaruFit
//
//  Created by 김시종 on 1/7/25.
//

import SwiftUI
import SwiftData

@main
struct HaruFitApp: App {
    private let container = DIContainer()

    @State private var isActive = false

    var body: some Scene {
        WindowGroup {
            if container.userSessionRepository.fetchIsLoggedIn() {
                RouteTabView()
            } else {
                UserSessionView(viewModel: container.makeUserInfoViewModel())
            }
        }
    }
}
