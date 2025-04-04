//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

public enum ChatbotError: Error {
    case apiError(underlying: Error?)
    case emptyResponse
    case invalidResponseFormat(underlying: Error?)
    case unknown(underlying: Error?)

    public var localizedDescription: String {
        switch self {
        case .apiError:
            return "API 호출 중 에러가 발생했습니다."
        case .emptyResponse:
            return "채팅 서비스 응답이 없습니다."
        case .invalidResponseFormat:
            return "채팅 서비스 응답 형식이 올바르지 않습니다."
        case .unknown:
            return "알 수 없는 채팅 서비스 에러가 발생했습니다."
        }
    }
}
