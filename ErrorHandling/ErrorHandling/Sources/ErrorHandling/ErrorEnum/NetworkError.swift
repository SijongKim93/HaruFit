//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

public enum NetworkError: Error {
    case networkError(code: Int, underlying: Error?)
    case noInternetConnection
    case yesInternetConnection
    case timeout
    case invalidResponse
    case unknown(underlying: Error?)

    public var localizedDescription: String {
        switch self {
        case .networkError(let code, _):
            return "네트워크 오류가 발생했습니다. 오류 코드: \(code)"
        case .noInternetConnection:
            return "인터넷 연결이 없습니다."
        case .yesInternetConnection:
            return "인터넷 연결되었습니다."
        case .timeout:
            return "네트워크 요청 시간이 초과되었습니다."
        case .invalidResponse:
            return "잘못된 응답을 받았습니다."
        case .unknown:
            return "알 수 없는 네트워크 오류가 발생했습니다."
        }
    }
}
