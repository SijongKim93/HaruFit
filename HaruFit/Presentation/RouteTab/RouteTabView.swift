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
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                switch selectedTab {
                case .workout:
                    WorksoutView()
                case .collect:
                    CollectView()
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
                .frame(height: 80)
                .background(
                    RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20)
                        .fill(Color.backgroundBlack)
                    
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: -2)
                )
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    RouteTabView()
}

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    RouteTabView()
}
