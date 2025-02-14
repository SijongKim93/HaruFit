//
//  UserInfoStepView.swift
//  HaruFit
//
//  Created by 김시종 on 2/14/25.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundBlack.ignoresSafeArea()
            
            ZStack {
                if viewModel.currentStep == .nickname {
                    nicknameStepView
                        .transition(.move(edge: .trailing))
                } else if viewModel.currentStep == .gender {
                    genderStepView
                        .transition(.move(edge: .trailing))
                } else if viewModel.currentStep == .age {
                    ageStepView
                        .transition(.move(edge: .trailing))
                } else {
                    completeStepView
                        .transition(.move(edge: .trailing))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}
