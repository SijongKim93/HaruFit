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
            
            VStack(spacing: 20) {
                headerArea
                
                Spacer()
    
                ZStack {
                    if viewModel.currentStep == .nickname {
                        NicknameInputContent(viewModel: viewModel)
                            .transition(.move(edge: .trailing))
                    } else if viewModel.currentStep == .gender {
                        GenderInputContent(viewModel: viewModel)
                            .transition(.move(edge: .trailing))
                    } else if viewModel.currentStep == .age {
                        AgeInputContent(viewModel: viewModel)
                            .transition(.move(edge: .trailing))
                    } else {
                        CompleteContent()
                            .transition(.move(edge: .trailing))
                    }
                }
                .frame(height: 300)
                
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
    }
    
    private var headerArea: some View {
        Group {
            switch viewModel.currentStep {
            case .nickname:
                HeaderTextView(title: "닉네임을 입력해주세요.", subTitle: "어떻게 불러드릴까요?")
            case .gender:
                HeaderTextView(title: "성별을 선택해주세요.", subTitle: nil)
            case .age:
                HeaderTextView(title: "연령대를 선택해주세요.", subTitle: nil)
            case .complete:
                HeaderTextView(title: "축하합니다. \n설정이 완료되었습니다!", subTitle: nil)
            }
        }
        .padding()
    }
}

struct NicknameInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel  // 또는 상위에서 전달
    
    var body: some View {
        // 예시: 단순 텍스트 필드 (SingleLineTextField 사용 가능)
        SingleLineTextField(text: $viewModel.nickname, placeholder: "닉네임 입력")
    }
}

struct GenderInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Button("남성") { viewModel.selectedGender = "M" }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.selectedGender == "M" ? Color.accentColor : Color.gray)
                .cornerRadius(8)
                .foregroundColor(.white)
            
            Button("여성") { viewModel.selectedGender = "F" }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.selectedGender == "F" ? Color.accentColor : Color.gray)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
    }
}

struct AgeInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    @State private var ageText: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("나이 입력", text: $ageText)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
    }
}

struct CompleteContent: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("모든 설정이 완료되었습니다!")
                .font(.title)
                .foregroundColor(.white)
            Text("메인 화면으로 이동하세요.")
                .foregroundColor(.white.opacity(0.8))
        }
    }
}
