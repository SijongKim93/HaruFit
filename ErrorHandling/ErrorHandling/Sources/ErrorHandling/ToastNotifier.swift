//
//  File.swift
//  ErrorHandling
//
//  Created by SiJongKim on 4/2/25.
//

import Foundation
import SwiftUI
import Combine

public protocol ToastNotifying {
    @MainActor func showToast(message: String)
}

@MainActor
public final class ToastNotifier: ObservableObject, ToastNotifying {
    @Published public var toastMessage: String? = nil

    public init() {}

    public func showToast(message: String) {
        withAnimation(.spring(response: 0.3)) {
            toastMessage = message
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            withAnimation(.easeOut(duration: 0.2)) {
                self?.toastMessage = nil
            }
        }
    }
}
