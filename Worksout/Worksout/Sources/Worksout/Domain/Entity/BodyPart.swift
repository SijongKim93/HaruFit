import Foundation

public enum BodyPart: CaseIterable {
    case back
    case chest
    case shoulder
    case lowerBody
    case fullBody
    case core

    public var title: String {
        switch self {
        case .back:
            return "등"
        case .chest:
            return "가슴"
        case .shoulder:
            return "어깨"
        case .lowerBody:
            return "하체"
        case .fullBody:
            return "전신"
        case .core:
            return "코어"
        }
    }
}
