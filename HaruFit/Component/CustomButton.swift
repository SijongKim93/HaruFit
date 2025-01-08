//
//  CustomButton.swift
//  HaruFit
//
//  Created by SiJongKim on 1/8/25.
//

import SwiftUI

struct CustomButton: View {
    enum ButtonSize {
        case large
        case medium
        case small
    }

    let title: String
    let size: ButtonSize
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .b1()
                .foregroundColor(foregroundColor)
                .frame(width: buttonWidth, height: 52)
                .background(backgroundColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor ?? .clear, lineWidth: 1)
                )
        }
        .frame(maxWidth: size == .large ? .infinity : buttonWidth)
    }

    private var buttonWidth: CGFloat? {
        switch size {
        case .large:
            return UIScreen.main.bounds.width - 48
        case .medium:
            return 280
        case .small:
            return 140
        }
    }
}
