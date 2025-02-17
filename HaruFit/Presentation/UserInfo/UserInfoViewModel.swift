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
        case nickname, gender, age, complete
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
            if userSessionUseCase.validateNickname(nickname) {
                currentStep = .gender
            }
        case .gender:
            if userSessionUseCase.validateGender(selectedGender) {
                currentStep = .age
            }
        case .age:
            if userSessionUseCase.validateAgeGroup(ageGroup) {
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
    
    var isNextEnabled: Bool {
        switch currentStep {
        case .nickname:
            return userSessionUseCase.validateNickname(nickname)
        case .gender:
            return userSessionUseCase.validateGender(selectedGender)
        case .age:
            return userSessionUseCase.validateAgeGroup(ageGroup)
        case .complete:
            return false
        }
    }
    
    var progress: Double {
        switch currentStep {
        case .nickname: return 1.0 / 3.0
        case .gender:   return 2.0 / 3.0
        case .age:      return 1.0
        case .complete: return 1.0
        }
    }
}
