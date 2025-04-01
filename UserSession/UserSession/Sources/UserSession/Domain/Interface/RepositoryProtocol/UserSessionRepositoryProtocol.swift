import Foundation

public protocol UserSessionRepository {
    func save(session: UserSession)
    func saveNickname(nickname: String)
    func saveGender(gender: String)
    func saveAgeGroup(ageGroup: String)
    func load() -> UserSession?
    func clear()
    func fetchNickname() -> String?
    func fetchIsLoggedIn() -> Bool
}
