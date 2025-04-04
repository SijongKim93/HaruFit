//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation

@MainActor
public final class ErrorHandler {
    public static let shared = ErrorHandler()

    public let toastNotifier: ToastNotifier

    private init(toastNotifier: ToastNotifier = ToastNotifier()) {
        self.toastNotifier = toastNotifier
    }

    public func handle(error: Error) {
        toastNotifier.showToast(message: error.localizedDescription)
    }
}
