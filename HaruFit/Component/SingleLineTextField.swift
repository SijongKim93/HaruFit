//
//  SingleLineTextField.swift
//  HaruFit
//
//  Created by 김시종 on 2/15/25.
//

import SwiftUI

struct SingleLineTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    let placeholder: String
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("", text: $text)
                .h1()
                .focused($isFocused)
                .foregroundColor(isFocused ? .interactionDisable : .interactionInactive)
                .textFieldStyle(.plain)
                .frame(height: 30)
                .overlay(
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(isFocused ? .interactionDisable.opacity(0.5)
                                                             : .interactionInactive.opacity(0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                , alignment: .leading)
            
            Rectangle()
                .fill(isFocused ? Color.interactionDisable : Color.interactionInactive)
                .frame(height: 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
}

struct SingleLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        SingleLineTextField(
            text: .constant(""),
            placeholder: "닉네임 입력 ( 2자 이상 )"
        )
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
