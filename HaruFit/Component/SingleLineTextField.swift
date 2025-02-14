//
//  SingleLineTextField.swift
//  HaruFit
//
//  Created by 김시종 on 2/15/25.
//

import SwiftUI

struct SingleLineTextField: View {
    @Binding var text: String
    
    // 포커스 상태를 추적
    @FocusState private var isFocused: Bool
    
    // placeholder
    let placeholder: String
    
    var body: some View {
        VStack(spacing: 4) {
            // 실제 텍스트필드
            TextField("", text: $text)
                .focused($isFocused)
                // 포커스 여부에 따라 글자색 변경
                .foregroundColor(isFocused ? .interactionDisable : .interactionInactive)
                .textFieldStyle(.plain)
                .frame(height: 20)
                .overlay(
                    // Placeholder 직접 구현
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(isFocused ? .interactionDisable.opacity(0.5)
                                                             : .interactionInactive.opacity(0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                , alignment: .leading)
            
            // 밑줄 (height: 1)
            Rectangle()
                .fill(isFocused ? Color.interactionDisable : Color.interactionInactive)
                .frame(height: 1)
        }
        .contentShape(Rectangle()) // 탭 영역
        .onTapGesture {
            // 탭 시 포커스
            isFocused = true
        }
    }
}

struct SingleLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        // 예: 테스트용
        SingleLineTextField(
            text: .constant(""),
            placeholder: "닉네임 입력"
        )
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}

