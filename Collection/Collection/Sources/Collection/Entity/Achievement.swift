import Foundation

public struct Achievement: Equatable, Identifiable {
    public let id: String
    public let name: String
    public let description: String
    public let iconName: String

    public var isUnlocked: Bool
}
