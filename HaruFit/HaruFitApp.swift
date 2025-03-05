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

    var body: some Scene {
        WindowGroup {
            RouteTabView()
                .modelContainer(container.modelContainer)
        }
    }
}
