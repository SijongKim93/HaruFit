//
//  HCalendarViewModel.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI
import Combine

class HCalendarViewModel: ObservableObject {
    @Published var dailyDataCount: [Date: Int] = [:]

    private var cancellables: Set<AnyCancellable> = []

    init() {

    }

    func setDummyData() {
        let today = Date().startOfDay
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: today)!

        self.dailyDataCount = [
            today : 2,
            yesterday : 1,
            twoDaysAgo : 0
        ]
    }


}

