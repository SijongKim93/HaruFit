import Foundation
import SwiftUI

public final class AppStorageUserSessionRepository: UserSessionRepository {
    @AppStorage("userId") private var userId: String?
    @AppStorage("nickname") private var nickname: String?
    @AppStorage("gender") private var gender: String?
    @AppStorage("ageGroup") private var ageGroup: String?
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("profileImageBase64") private var profileImageBase64: String?

    public init() { }

    public func save(session: UserSession) {
        userId = session.userId.uuidString
        nickname = session.nickname
        gender = session.gender
        ageGroup = session.ageGroup
        isLoggedIn = true

        if let imageData = session.proflieImageData {
            profileImageBase64 = imageData.base64EncodedString()
        } else {
            profileImageBase64 = nil
        }
    }

    public func saveNickname(nickname: String) {
        self.nickname = nickname
    }

    public func saveGender(gender: String) {
        self.gender = gender
    }

    public func saveAgeGroup(ageGroup: String) {
        self.ageGroup = ageGroup
        isLoggedIn = true
    }

    public func load() -> UserSession? {
        guard let idString = userId,
              let id = UUID(uuidString: idString),
              isLoggedIn else { return nil }

        let decodedData = profileImageBase64.flatMap { Data(base64Encoded: $0) }

        return UserSession(
            userId: id,
            nickname: nickname ?? "",
            profileImageData: decodedData ?? Data(),
            gender: gender ?? "",
            ageGroup: ageGroup ?? "",
            isLoggedIn: isLoggedIn
        )
    }

    public func clear() {
        userId = nil
        nickname = nil
        gender = nil
        ageGroup = nil
        isLoggedIn = false
    }

    public func fetchNickname() -> String? {
        return nickname
    }

    public func fetchIsLoggedIn() -> Bool {
        return isLoggedIn
    }
}
