//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

public enum SwiftDataError: Error {
    case fetchFailed(underlying: Error?)
    case insertionFailed(underlying: Error?)
    case deletionFailed(underlying: Error?)
    case updateFailed(underlying: Error?)
    case unknown(underlying: Error?)

    public var localizedDescription: String {
        switch self {
        case .fetchFailed:
            return "로컬 데이터를 불러오는데 실패했습니다."
        case .insertionFailed:
            return "로컬 데이터를 추가하는데 실패했습니다."
        case .deletionFailed:
            return "로컬 데이터를 삭제하는데 실패했습니다."
        case .updateFailed:
            return "로컬 데이터 업데이트에 실패했습니다."
        case .unknown:
            return "알 수 없는 로컬 데이터 오류가 발생했습니다."
        }
    }
}
