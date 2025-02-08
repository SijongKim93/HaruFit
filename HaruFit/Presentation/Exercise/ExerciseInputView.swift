//
//  ExerciseInputView.swift
//  HaruFit
//
//  Created by 김시종 on 2/8/25.
//

import SwiftUI

struct ExerciseInputView: View {
    var onSelectExercise: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("운동 선택")
                .h1()
                .padding()
            
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        Text("상체 운동")
                            .font(.subheadline)
                            .bold()
                        HStack(spacing: 15) {
                            Button("벤치 프레스") {
                                onSelectExercise("벤치 프레스")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                            
                            Button("푸쉬업") {
                                onSelectExercise("푸쉬업")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                        }
                    }
                    Group {
                        Text("하체 운동")
                            .font(.subheadline)
                            .bold()
                        HStack(spacing: 15) {
                            Button("스쿼트") {
                                onSelectExercise("스쿼트")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                            
                            Button("런지") {
                                onSelectExercise("런지")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                        }
                    }
                    Group {
                        Text("코어 운동")
                            .font(.subheadline)
                            .bold()
                        HStack(spacing: 15) {
                            Button("플랭크") {
                                onSelectExercise("플랭크")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                            
                            Button("크런치") {
                                onSelectExercise("크런치")
                            }
                            .buttonStyle(ExerciseButtonStyle())
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ExerciseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.backgroundGray.opacity(configuration.isPressed ? 0.7 : 1.0))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}
