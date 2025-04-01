import SwiftUI
import UserSession

final class UserSessionViewModel: ObservableObject {
    enum Step: Int {
        case nickname, gender, age, complete
    }

    @Published var session: UserSession?
    @Published var nickname: String = ""
    @Published var gender: String = ""
    @Published var ageGroup: String = ""
    @Published var profileImage: UIImage? = nil
    @Published var currentStep: Step = .nickname

    private let userSessionUseCase: UserSessionUseCase

    init(userSessionUseCase: UserSessionUseCase = DIContainer.shared.userSessionUseCase) {
        self.userSessionUseCase = userSessionUseCase
        loadSession()
    }

    func nextStep() {
        switch currentStep {
        case .nickname:
            if userSessionUseCase.validateNickname(nickname) {
                let imageData = profileImage?.jpegData(compressionQuality: 0.8) ?? Data()
                let partialSession = UserSession(
                    userId: UUID(),
                    nickname: nickname,
                    profileImageData: imageData,
                    gender: "",
                    ageGroup: "",
                    isLoggedIn: false
                )
                userSessionUseCase.save(session: partialSession)
                currentStep = .gender
            }
        case .gender:
            if userSessionUseCase.validateGender(gender) {
                var current = userSessionUseCase.load() ?? UserSession(
                    userId: UUID(),
                    nickname: nickname,
                    profileImageData: profileImage?.jpegData(compressionQuality: 0.8) ?? Data(),
                    gender: "",
                    ageGroup: "",
                    isLoggedIn: false
                )
                current = UserSession(
                    userId: current.userId,
                    nickname: current.nickname,
                    profileImageData: current.proflieImageData ?? Data(),
                    gender: gender,
                    ageGroup: current.ageGroup,
                    isLoggedIn: false
                )
                userSessionUseCase.save(session: current)
                currentStep = .age
            }
        case .age:
            if userSessionUseCase.validateAgeGroup(ageGroup) {
                var current = userSessionUseCase.load() ?? UserSession(
                    userId: UUID(),
                    nickname: nickname,
                    profileImageData: profileImage?.jpegData(compressionQuality: 0.8) ?? Data(),
                    gender: gender,
                    ageGroup: "",
                    isLoggedIn: false
                )
                current = UserSession(
                    userId: current.userId,
                    nickname: current.nickname,
                    profileImageData: current.proflieImageData ?? Data(),
                    gender: current.gender,
                    ageGroup: ageGroup,
                    isLoggedIn: false
                )
                userSessionUseCase.save(session: current)
                currentStep = .complete
            }
        case .complete:
            if let current = userSessionUseCase.load() {
                let finalSession = UserSession(
                    userId: current.userId,
                    nickname: current.nickname,
                    profileImageData: current.proflieImageData ?? Data(),
                    gender: current.gender,
                    ageGroup: current.ageGroup,
                    isLoggedIn: true
                )
                userSessionUseCase.save(session: finalSession)
                session = finalSession
            }
        }
    }

    func loadSession() {
        if let loadedSession = userSessionUseCase.load() {
            session = loadedSession
        } else {
            print("UserSession 정보 로드 실패")
        }
    }

    func clearSession() {
        userSessionUseCase.clear()
        session = nil
    }

    var isNextEnabled: Bool {
        switch currentStep {
        case .nickname:
            return userSessionUseCase.validateNickname(nickname)
        case .gender:
            return userSessionUseCase.validateGender(gender)
        case .age:
            return userSessionUseCase.validateAgeGroup(ageGroup)
        case .complete:
            return true
        }
    }
}
