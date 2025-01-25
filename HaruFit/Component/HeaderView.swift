//
//  HeaderView.swift
//  HaruFit
//
//  Created by 김시종 on 1/25/25.
//

import SwiftUI

struct HeaderView: View {
    let profileImage: Image
    let nickname: String
    
    let onSettingsTapped: () -> Void
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea(edges: .top)
            
            HStack(spacing: 16) {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("어서오세요")
                        .b4()
                        .foregroundColor(.interactionInactive)
                    Text(nickname)
                        .b2()
                        .foregroundColor(.interactionDisable)
                }
                
                Spacer()
                
                Button(action: {
                    onSettingsTapped()
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.interactionInactive)
                })
            }
            .padding(.horizontal)
            .padding(.top, 40)
            .padding(.bottom, 12)
        }
        .frame(height: 100)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(
            profileImage: Image(systemName: "person.circle.fill"),
            nickname: "ShawnKim"
        ) {
            print("Settings tapped!")
        }
        .previewLayout(.sizeThatFits)
    }
}
