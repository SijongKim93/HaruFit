//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

public enum FirebaseError: Error {
    case authenticationFailed(underlying: Error?)
    case dataFetchFailed(underlying: Error?)
    case dataWriteFailed(underlying: Error?)
    case unknown(underlying: Error?)

    public var localizedDescription: String {
        switch self {
        case .authenticationFailed:
            return "Firebase 인증에 실패했습니다."
        case .dataFetchFailed:
            return "Firebase에서 데이터를 가져오는데 실패했습니다."
        case .dataWriteFailed:
            return "Firebase에서 데이터를 저장하는데 실패했습니다."
        case .unknown:
            return "알 수 없는 Firebase 에러가 발생했습니다."
        }
    }
}
