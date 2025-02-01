//
//  MyStateView.swift
//  HaruFit
//
//  Created by 김시종 on 2/1/25.
//

import SwiftUI

struct MyStateView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.backgroundGray)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            HStack(spacing: 20) {
                VStack {
                    Text("Calories")
                        .h1()
                        .foregroundColor(.interactionDisable)
                    
                    Text("730")
                        .h1()
                        .foregroundColor(.interactionInactive)
                }
                
                VStack {
                    Text("Sleep")
                        .h1()
                        .foregroundColor(.interactionDisable)
                    
                    Text("5/8")
                        .h1()
                        .foregroundColor(.interactionInactive)
                }
                
                VStack {
                    Text("Hours")
                        .h1()
                        .foregroundColor(.interactionDisable)
                    
                    Text("Session")
                        .h1()
                        .foregroundColor(.interactionInactive)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    MyStateView()
}
