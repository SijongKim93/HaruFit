//
//  HeaderView.swift
//  HaruFit
//
//  Created by 김시종 on 1/25/25.
//

import SwiftUI

struct HeaderView: View {
    @AppStorage("userId") private var storedUserId: String?
    @AppStorage("nickname") private var storedNickname: String?
    @AppStorage("profileImageBase64") private var storedProfileImageBase64: String?
    
    //let onSettingsTapped: () -> Void
    
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
                    if let nickname = storedNickname {
                        Text("어서오세요")
                            .b4()
                            .foregroundColor(.interactionInactive)
                        Text(nickname)
                            .b2()
                            .foregroundColor(.interactionDisable)
                    } else {
                        Text("로그인이 필요합니다.")
                            .b2()
                            .foregroundColor(.interactionInactive)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    //onSettingsTapped()
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.interactionInactive)
                })
                .opacity(storedUserId == nil ? 0 : 1)
            }
            .padding(.horizontal)
            .padding(.top, 0)
        }
        .frame(height: 60)
    }
    
    private var profileImage: Image {
        if let base64String = storedProfileImageBase64,
           let data = Data(base64Encoded: base64String),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
}

#Preview {
    HeaderView()
}
