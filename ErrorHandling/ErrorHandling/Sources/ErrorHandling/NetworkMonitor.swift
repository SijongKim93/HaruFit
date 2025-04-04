//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation
import Network
import Combine
import SwiftUI

@MainActor
public final class NetworkMonitor: ObservableObject {
    public static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")

    @Published public var isConnected: Bool = true

    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                let newStatus = (path.status == .satisfied)

                if self.isConnected != newStatus {
                    self.isConnected = newStatus
                    if newStatus {
                        ErrorHandler.shared.toastNotifier.showToast(message: NetworkError.yesInternetConnection.localizedDescription)
                    } else {
                        ErrorHandler.shared.toastNotifier.showToast(message: NetworkError.noInternetConnection.localizedDescription)
                    }
                }
            }
        }
        monitor.start(queue: queue)
    }

    public func startMonitoring() {
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}

public func performWithRetry<T>(
    retryCount: Int = 3,
    initialDelay: TimeInterval = 1,
    task: @escaping () async throws -> T
) async throws -> T {
    var attempt = 0
    var delay = initialDelay

    while attempt <= retryCount {
        do {
            return try await task()
        } catch {
            await ErrorHandler.shared.handle(error: error)

            if attempt == retryCount {
                throw error
            }

            if await !NetworkMonitor.shared.isConnected {
                try await Task.sleep(nanoseconds: 3_000_000_000)
            } else {
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                delay *= 2
                attempt += 1
            }
        }
    }

    throw NetworkError.unknown(underlying: nil)
}
