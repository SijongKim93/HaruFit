//
//  ExerciseInputView.swift
//  HaruFit
//
//  Created by 김시종 on 2/8/25.
//

import SwiftUI

struct ExerciseInputView: View {
    var onSelectExercise: (String) -> Void
    @State private var selectedBodyPart: BodyPart = .back
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                HStack {
                    HStack {
                        Image("dumbell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("운동 선택")
                            .h1()
                            .foregroundColor(Color.interactionDisable)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        onSelectExercise("")
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.interactionDisable)
                    }
                    .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(BodyPart.allCases, id: \.self) { part in
                            Button(action: {
                                selectedBodyPart = part
                            }) {
                                Text(part.title)
                                    .b1()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedBodyPart == part ? Color.accent : Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                                    .foregroundColor(selectedBodyPart == part ? Color.interactionDisable : Color.interactionInactive)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                }
            
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(ExerciseResource.exercises(for: selectedBodyPart), id: \.self) { exercise in
                            Button(action: {
                                onSelectExercise(exercise)
                            }) {
                                Text(exercise)
                                    .b1()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.backgroundGray.opacity(0.5))
                                    .cornerRadius(12)
                                    .foregroundColor(.interactionDisable)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal)
            }
        }
    }
}
