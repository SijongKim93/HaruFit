import Foundation

public final class DefaultUserSessionUseCase: UserSessionUseCase {
    private let repository: UserSessionRepository

    public init(repository: UserSessionRepository) {
        self.repository = repository
    }

    public func save(session: UserSession) {
        repository.save(session: session)
    }

    public func load() -> UserSession? {
        return repository.load()
    }

    public func clear() {
        repository.clear()
    }

    public func validateNickname(_ nickname: String) -> Bool {
        return nickname.count >= 2
    }

    public func validateGender(_ gender: String) -> Bool {
        return !gender.isEmpty
    }

    public func validateAgeGroup(_ ageGroup: String) -> Bool {
        return !ageGroup.isEmpty
    }

    public func saveNickname(nickname: String) {
        repository.saveNickname(nickname: nickname)
    }

    public func saveGender(gender: String) {
        repository.saveGender(gender: gender)
    }

    public func saveAgeGroup(ageGroup: String) {
        repository.saveAgeGroup(ageGroup: ageGroup)
    }
}
