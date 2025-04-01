//
//  TabItems.swift
//  HaruFit
//
//  Created by SiJongKim on 1/8/25.
//

import Foundation

enum Tab: CaseIterable {
    case workout, collect, record

    var title: String {
        switch self {
        case .workout:
            return "운동"
        case .collect:
            return "수집품"
        case .record:
            return "기록"
        }
    }

    var seletedImage: String {
        switch self {
        case .workout:
            return AppImage.TabBar.workouton
        case .collect:
            return AppImage.TabBar.collecton
        case .record:
            return AppImage.TabBar.recordon
        }
    }

    var unselectedImage: String {
        switch self {
        case .workout:
            return AppImage.TabBar.workoutoff
        case .collect:
            return AppImage.TabBar.collectoff
        case .record:
            return AppImage.TabBar.recordoff
        }
    }
}
