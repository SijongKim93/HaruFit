//
//  TabItems.swift
//  HaruFit
//
//  Created by SiJongKim on 1/8/25.
//

import Foundation

enum Tab: CaseIterable {
    case workout, time, collect, record

    var title: String {
        switch self {
        case .workout:
            return "운동 설정"
        case .time:
            return "스탑 워치"
        case .collect:
            return "수집품"
        case .record:
            return "기록"
        }
    }

    var seletedImage: String {
        switch self {
        case .workout:
            return AppImages.TabBar.workouton
        case .time:
            return AppImages.TabBar.timeon
        case .collect:
            return AppImages.TabBar.collecton
        case .record:
            return AppImages.TabBar.recordon
        }
    }

    var unselectedImage: String {
        switch self {
        case .workout:
            return AppImages.TabBar.workoutoff
        case .time:
            return AppImages.TabBar.timeoff
        case .collect:
            return AppImages.TabBar.collectoff
        case .record:
            return AppImages.TabBar.recordoff
        }
    }
}
