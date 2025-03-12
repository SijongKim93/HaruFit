import SwiftUI

struct UserInfoView: View {
    @ObservedObject var viewModel: UserInfoViewModel
    @State private var navigateToWorksout: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundBlack
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    headerArea

                    Spacer()

                    // 현재 단계에 따라 단일 입력 콘텐츠 영역 표시
                    inputContent
                        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                 removal: .move(edge: .leading)))
                        .frame(height: 300)

                    Spacer()

                    CustomButton(
                        title: "다음",
                        size: .large,
                        backgroundColor: viewModel.isNextEnabled ? Color.accent : Color.interactionInactive,
                        foregroundColor: .interactionDisable,
                        borderColor: nil,
                        action: { handleNext() }
                    )
                    .disabled(!viewModel.isNextEnabled)

                    Spacer()
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToWorksout) {
                RouteTabView()
            }
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
                HeaderTextView(title: "설정이 완료되었습니다!", subTitle: nil)
            }
        }
    }

    @ViewBuilder
    private var inputContent: some View {
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

    private func handleNext() {
        guard viewModel.isNextEnabled else { return }
        if viewModel.currentStep == .complete {
            navigateToWorksout = true
            return
        }
        withAnimation(.easeInOut(duration: 0.3)) {
            switch viewModel.currentStep {
            case .nickname:
                viewModel.currentStep = .gender
            case .gender:
                viewModel.currentStep = .age
            case .age:
                viewModel.currentStep = .complete
            case .complete:
                break
            }
        }
    }
}

struct NicknameInputContent: View {
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        SingleLineTextField(text: $viewModel.nickname, placeholder: "닉네임 입력 (2자 이상)")
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
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(ageGroups, id: \.self) { group in
                Button {
                    viewModel.ageGroup = group
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(viewModel.ageGroup == group ? Color.accent : Color.gray)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                        Text(group)
                            .foregroundColor(.interactionDisable)
                            .h1()
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
            }
        }
    }
}

struct CompleteContent: View {
    var body: some View {
        CheckAnimationView()
    }
}

#Preview {
    UserInfoView(viewModel: DIContainer.shared.makeUserInfoViewModel())
}


// nextStep에 대한 저장 로직실행이 뷰에서 이뤄지지 않고있음
