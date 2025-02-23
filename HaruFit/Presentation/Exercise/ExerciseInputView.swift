//
//  ExerciseInputView.swift
//  HaruFit
//
//  Created by 김시종 on 2/8/25.
//

import SwiftUI

struct ExerciseInputView: View {
    var onSelectExercise: (String) -> Void
    
    // 예시: 각 부위별 더미 운동 목록
    let exercisesByBodyPart: [BodyPart: [String]] = [
        .back: ["풀업", "친업", "랫 풀다운"],
        .chest: ["벤치프레스", "푸쉬업", "딥스"],
        .shoulder: ["숄더프레스", "사이드레터럴"],
        .lowerBody: ["스쿼트", "런지", "레그프레스"],
        .fullBody: ["버피", "마운틴클라이머"],
        .core: ["플랭크", "크런치", "레그레이즈"]
    ]
    
    @State private var selectedBodyPart: BodyPart = .back
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("운동 선택")
                    .h1()
                    .padding()
                    .foregroundColor(Color.interactionDisable)
                
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
                    .padding(.horizontal)
                }
                
                if let exercises = exercisesByBodyPart[selectedBodyPart] {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(exercises, id: \.self) { exercise in
                            Button(action: {
                                onSelectExercise(exercise)
                            }) {
                                Text(exercise)
                                    .font(.body)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.backgroundGray.opacity(0.5))
                                    .cornerRadius(12)
                                    .foregroundColor(.interactionDisable)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}
