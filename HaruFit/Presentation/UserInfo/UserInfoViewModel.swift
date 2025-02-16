//
//  UserInfoViewModel.swift
//  HaruFit
//
//  Created by 김시종 on 2/14/25.
//

import SwiftUI
import Combine

final class UserInfoViewModel: ObservableObject {
    enum Step: Int {
        case nickname = 0, gender, age, complete
    }
    
    @Published var nickname: String = ""
    @Published var selectedGender: String = ""
    @Published var ageGroup: String = ""
    
    @Published var currentStep: Step = .nickname
    
    private let userSessionUseCase: UserSessionUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(userSessionUseCase: UserSessionUseCase) {
        self.userSessionUseCase = userSessionUseCase
    }
    
    func nextStep() {
        switch currentStep {
        case .nickname:
            if nickname.count >= 2 {
                currentStep = .gender
            }
        case .gender:
            if !selectedGender.isEmpty {
                currentStep = .age
            }
        case .age:
            if !ageGroup.isEmpty {
                saveUserSession()
                currentStep = .complete
            }
        case .complete:
            break
        }
    }
    
    private func saveUserSession() {
        _ = userSessionUseCase.login(
            userId: "testUserId",
            gender: selectedGender,
            ageGroup: ageGroup,
            nickname: nickname,
            profileImageData: nil
        )
    }
    
    var progress: Double {
        switch currentStep {
        case .nickname: return 1.0 / 3.0
        case .gender: return 2.0 / 3.0
        case .age: return 3.0 / 3.0
        case .complete: return 1.0
        }
    }
}
