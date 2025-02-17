import SwiftUI

struct UserInfoView: View {
    @ObservedObject var viewModel: UserInfoViewModel
    @State private var incomingStep: UserInfoViewModel.Step? = nil
    @State private var incomingOffset: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.backgroundBlack.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                headerArea
                
                Spacer()
                
                ZStack {
                    currentStepView
                    if let step = incomingStep {
                        stepView(for: step)
                            .offset(x: incomingOffset)
                    }
                }
                .frame(height: 300)
                
                Spacer()
                
                CustomButton(
                    title: "다음",
                    size: .large,
                    backgroundColor: viewModel.isNextEnabled ? Color.accent : Color.interactionInactive,
                    foregroundColor: .interactionDisable,
                    borderColor: nil,
                    action: {
                        handleNext()
                    }
                )
                .disabled(!viewModel.isNextEnabled)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private var headerArea: some View {
        Group {
            switch viewModel.currentStep {
            case .nickname:
                HeaderTextView(title: "닉네임을 입력해주세요.", subTitle: nil)
            case .gender:
                HeaderTextView(title: "성별을 선택해주세요.", subTitle: nil)
            case .age:
                HeaderTextView(title: "연령대를 선택해주세요.", subTitle: nil)
            case .complete:
                HeaderTextView(title: "설정이 완료되었습니다!", subTitle: nil)
            }
        }
    }
    
    // 현재 단계의 콘텐츠 (고정)
    @ViewBuilder
    private var currentStepView: some View {
        switch viewModel.currentStep {
        case .nickname:
            NicknameInputContent(viewModel: viewModel)
        case .gender:
            GenderInputContent(viewModel: viewModel)
        case .age:
            AgeInputContent(viewModel: viewModel)
        case .complete:
            CompleteContent()
        }
    }
    
    // 새로 들어올 단계의 콘텐츠 (오버레이)
    private func stepView(for step: UserInfoViewModel.Step) -> some View {
        switch step {
        case .nickname: return AnyView(NicknameInputContent(viewModel: viewModel))
        case .gender:   return AnyView(GenderInputContent(viewModel: viewModel))
        case .age:      return AnyView(AgeInputContent(viewModel: viewModel))
        case .complete: return AnyView(CompleteContent())
        }
    }
    
    private func handleNext() {
        guard viewModel.isNextEnabled else { return }
        let nextStep: UserInfoViewModel.Step
        switch viewModel.currentStep {
        case .nickname: nextStep = .gender
        case .gender:   nextStep = .age
        case .age:      nextStep = .complete
        case .complete: nextStep = .complete
        }
        incomingStep = nextStep
        incomingOffset = UIScreen.main.bounds.width
        withAnimation(.easeInOut(duration: 0.3)) {
            incomingOffset = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            viewModel.currentStep = nextStep
            incomingStep = nil
        }
    }
}

struct NicknameInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        SingleLineTextField(text: $viewModel.nickname, placeholder: "닉네임 입력 ( 2자 이상 )")
            .padding(.horizontal, 10)
    }
}

struct GenderInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                viewModel.selectedGender = "M"
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(viewModel.selectedGender == "M" ? Color.accent : Color.backgroundGray)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                    
                    VStack {
                        Image("male")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(10)
                        Text("남성")
                            .h1()
                            .foregroundColor(.interactionDisable)
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
                        .fill(viewModel.selectedGender == "F" ? Color.accent : Color.backgroundGray)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                    
                    VStack(spacing: 6) {
                        Image("female")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(10)
                        Text("여성")
                            .h1()
                            .foregroundColor(.interactionDisable)
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct AgeInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    let ageGroups = ["10대", "20대", "30대", "40대 이상"]
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                ForEach(ageGroups, id: \.self) { group in
                    Button {
                        viewModel.ageGroup = group
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.ageGroup == group ? Color.accent : Color.gray)
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                            Text(group)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

struct CompleteContent: View {
    var body: some View {
        VStack {
            Text("모든 설정이 완료되었습니다!")
                .font(.title)
                .foregroundColor(.white)
            Text("메인 화면으로 이동하세요.")
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    UserInfoView(viewModel: DIContainer.shared.makeUserInfoViewModel())
}
