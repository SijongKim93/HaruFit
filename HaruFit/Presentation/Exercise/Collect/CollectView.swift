//
//  CollectView.swift
//  HaruFit
//
//  Created by 김시종 on 2/13/25.
//

import SwiftUI

struct CollectView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView {
                VStack() {
                    Text("🏆 Collection 🏆")
                        .largeH1()
                        .padding()
                        .foregroundColor(.interactionDisable)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<10) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.backgroundGray.opacity(0.5))
                                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.backgroundBlack.opacity(0.8))
                                    
                                    Text("???")
                                        .h1()
                                        .foregroundColor(.interactionDisable)
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .background(Color.backgroundBlack)
    }
}

#Preview {
    CollectView()
}
