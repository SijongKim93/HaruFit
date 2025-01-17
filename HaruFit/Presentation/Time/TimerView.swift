//
//  TimerView.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

struct TimerView: View {
    @State private var selectedWorkout: Workout? = nil
    @State private var showWorkoutDetail = false

    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Text("운동을 선택하세요.")
                    .h1()
                    .foregroundColor(.labelAlternative)
                
                Button("웨이트 트레이닝") {
                    selectedWorkout = .weightTraining
                    showWorkoutDetail = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("런닝") {
                    selectedWorkout = .running
                    showWorkoutDetail = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("타바타") {
                    selectedWorkout = .tabata
                    showWorkoutDetail = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .fullScreenCover(isPresented: $showWorkoutDetail, content: {
                if let workout = selectedWorkout {
                    TimerDetailView(workout: workout) {
                        showWorkoutDetail = false
                    }
                }
            })
            
        }
    }
}


#Preview {
    TimerView()
}
