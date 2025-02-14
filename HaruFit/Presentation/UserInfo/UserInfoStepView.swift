//
//  UserInfoStepView.swift
//  HaruFit
//
//  Created by 김시종 on 2/14/25.
//

import SwiftUI

extension UserInfoView {
    var nicknameStepView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("닉네임을 입력해주세요.")
                .largeH1()
                .foregroundColor(.interactionDisable)
            
            Spacer()
            
            SingleLineTextField(
                text: $viewModel.nickname,
                placeholder: "NickName"
            )
            
            Spacer()
            
            CustomButton(
                title: "다음",
                size: .large,
                backgroundColor: .accent.opacity(0.5),
                foregroundColor: .interactionDisable,
                borderColor: nil,
                action: {
                    withAnimation {
                        viewModel.nextStep()
                    }
                }
            )
        }
        .padding()
        .background(Color.backgroundBlack)
    }
    
    var genderStepView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("성별을 선택해주세요.")
                .largeH1()
                .foregroundColor(.interactionDisable)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button {
                    viewModel.selectedGender = "M"
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(viewModel.selectedGender == "M" ? Color.interactionDisable : Color.interactionInactive)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                        
                        VStack(spacing: 20) {
                            Image("male")
                                .resizable()
                                .scaledToFit()
                                .padding(20)
                            
                            Text("남성")
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                }
                
                Button {
                    viewModel.selectedGender = "F"
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(viewModel.selectedGender == "F" ? Color.interactionDisable : Color.interactionInactive)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                        
                        VStack(spacing: 20) {
                            Image("female")
                                .resizable()
                                .scaledToFit()
                                .padding(20)
                            
                            Text("여성")
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                }
            }
            
            Spacer()
            
            CustomButton(
                title: "다음",
                size: .large,
                backgroundColor: .accent.opacity(0.5),
                foregroundColor: .interactionDisable,
                borderColor: nil,
                action: {
                    withAnimation {
                        viewModel.nextStep()
                    }
                }
            )
        }
        .padding()
    }
    
    var ageStepView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("연령대를 선택해주세요.")
                .largeH1()
                .foregroundColor(.interactionDisable)
            
            Spacer()
            
            CustomButton(
                title: "다음",
                size: .large,
                backgroundColor: .accent.opacity(0.5),
                foregroundColor: .interactionDisable,
                borderColor: nil,
                action: {
                    withAnimation {
                        viewModel.nextStep()
                    }
                }
            )
        }
    }
    
    var completeStepView: some View {
        VStack(spacing: 16) {
            Text("설정이 완료되었습니다!")
                
            Text("같이 한번 열심히 운동해봐요!")
        }
        .largeH1()
        .foregroundColor(.interactionDisable)
    }
}
