//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

public enum RecordingError: Error {
    case audioSessionConfigurationFailed(underlying: Error?)
    case audioSessionActivationFailed(underlying: Error?)
    case audioRecorderInitializationFailed(underlying: Error?)
    case recordingStartFailed(underlying: Error?)
    case unknown(underlying: Error?)

    public var localizedDescription: String {
        switch self {
        case .audioSessionConfigurationFailed:
            return "Audio 카테고리 설정에 실패했습니다."
        case .audioSessionActivationFailed:
            return "Audio 활성화에 실패했습니다."
        case .audioRecorderInitializationFailed:
            return "Audio 초기화에 실패했습니다."
        case .recordingStartFailed:
            return "녹음 시작을 실패했습니다."
        case .unknown:
            return "녹음 진행 시 알 수 없는 오류가 발생했습니다."
        }
    }
}
