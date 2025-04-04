//
//  ToastMessageView.swift
//  DepsChat
//
//  Created by SiJongKim on 4/2/25.
//

import SwiftUI
import ErrorHandling

struct ToastMessageView: View {
    @ObservedObject var notifier: ToastNotifier

    private var backgroundColor: Color {
        if let message = notifier.toastMessage, message == NetworkError.yesInternetConnection.localizedDescription {
            return Color.green
        } else {
            return Color.red
        }
    }

    var body: some View {
        VStack {
            if let message = notifier.toastMessage {
                Text(message)
                    .b1()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(backgroundColor)
                    .foregroundColor(.interactionDisable)
                    .cornerRadius(8)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))

            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
        .padding(.horizontal)
        .animation(.spring(response: 0.3), value: notifier.toastMessage != nil)
    }
}
