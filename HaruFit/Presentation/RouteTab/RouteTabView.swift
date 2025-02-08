//
//  RouteTabBar.swift
//  HaruFit
//
//  Created by SiJongKim on 1/8/25.
//

import SwiftUI

struct RouteTabView: View {
    @State private var selectedTab: Tab = .workout

    var body: some View {
        VStack {
            switch selectedTab {
            case .workout:
                WorksoutView()
            case .collect:
                WorksoutView()
            case .record:
                WorksoutView()
            }


            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        VStack(spacing: 5) {
                            Image(selectedTab == tab ? tab.seletedImage : tab.unselectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)

                            Text(tab.title)
                                .detail2()
                                .foregroundColor(selectedTab == tab ? Color.interactionDisable : Color.interactionInactive)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 70)
            
            Spacer()
        }
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    RouteTabView()
}
