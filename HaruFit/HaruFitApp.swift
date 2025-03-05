//
//  HaruFitApp.swift
//  HaruFit
//
//  Created by 김시종 on 1/7/25.
//

import SwiftUI

@main
struct HaruFitApp: App {
    private let container = DIContainer()

    var body: some Scene {
        WindowGroup {
            UserInfoView(viewModel: container.makeUserInfoViewModel())
                .modelContainer(container.modelContainer)
        }
    }
}
