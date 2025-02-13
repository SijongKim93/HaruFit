//
//  Font+Extension.swift
//  HaruFit
//
//  Created by SiJongKim on 1/8/25.
//

import SwiftUI

enum FontWeight {
    case regular
    case medium
    case semiBold
}

struct CustomFontStyle {
    let size: CGFloat
    let weight: FontWeight
    let lineHeight: CGFloat
}

extension Font {
    static func pretendardStyle(_ style: CustomFontStyle) -> Font {
        let fontName: String
        switch style.weight {
        case .regular:
            fontName = "PretendardVariable-Regular"
        case .medium:
            fontName = "PretendardVariable-Medium"
        case .semiBold:
            fontName = "PretendardVariable-SemiBold"
        }
        return Font.custom(fontName, size: style.size)
    }
}

extension View {
    func applyTextStyle(style: CustomFontStyle) -> some View {
        self.font(Font.pretendardStyle(style))
            .lineSpacing((style.lineHeight - 1) * style.size)
            .kerning(-0.32)
            .frame(minHeight: style.size * style.lineHeight)
    }

    // MARK: - Headline
    
    func largeH1() -> some View {
        let style = CustomFontStyle(size: 32, weight: .semiBold, lineHeight: 1.3)
        return applyTextStyle(style: style)
    }

    func h1() -> some View {
        let style = CustomFontStyle(size: 22, weight: .semiBold, lineHeight: 1.3)
        return applyTextStyle(style: style)
    }

    func h2() -> some View {
        let style = CustomFontStyle(size: 20, weight: .semiBold, lineHeight: 1.4)
        return applyTextStyle(style: style)
    }

    // MARK: - Body

    func b1() -> some View {
        let style = CustomFontStyle(size: 16, weight: .semiBold, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func b2() -> some View {
        let style = CustomFontStyle(size: 16, weight: .medium, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func b3() -> some View {
        let style = CustomFontStyle(size: 16, weight: .regular, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func b4() -> some View {
        let style = CustomFontStyle(size: 15, weight: .semiBold, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func b5() -> some View {
        let style = CustomFontStyle(size: 15, weight: .regular, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func b6() -> some View {
        let style = CustomFontStyle(size: 14, weight: .medium, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    // MARK: - Detail

    func detail1() -> some View {
        let style = CustomFontStyle(size: 13, weight: .semiBold, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func detail11() -> some View {
        let style = CustomFontStyle(size: 13, weight: .regular, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }

    func detail2() -> some View {
        let style = CustomFontStyle(size: 12, weight: .regular, lineHeight: 1.5)
        return applyTextStyle(style: style)
    }
}
