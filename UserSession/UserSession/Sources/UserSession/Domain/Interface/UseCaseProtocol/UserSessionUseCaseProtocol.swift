import Foundation

public protocol UserSessionUseCase {
    func save(session: UserSession)
    func saveNickname(nickname: String)
    func saveGender(gender: String)
    func saveAgeGroup(ageGroup: String)
    func load() -> UserSession?
    func clear()

    func validateNickname(_ nickname: String) -> Bool
    func validateGender(_ gender: String) -> Bool
    func validateAgeGroup(_ ageGroup: String) -> Bool
}
