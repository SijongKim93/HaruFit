//
//  TimerView.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

struct WorksoutView: View {
    @State private var selectedWorkout: Workout? = nil
    @State private var showWorkoutDetail = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("운동을 선택하세요.")
                    .h1()
                    .foregroundColor(.labelAlternative)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 10) {
                    workoutButton(
                        title: "Weight Training",
                        workout: .weightTraining
                    )
                    
                    workoutButton(
                        title: "Running",
                        workout: .running
                    )
                    
                    workoutButton(
                        title: "Tabata",
                        workout: .tabata
                    )
                    
                    workoutButton(
                        title: "Yoga",
                        workout: .yoga
                    )
                }
                
                Spacer()
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
    
    @ViewBuilder
    private func workoutButton(title: String, workout: Workout) -> some View {
        let imageName: String = {
            switch workout {
            case .weightTraining:
                return AppImages.WorkoutImage.weightTraining
            case .running:
                return AppImages.WorkoutImage.running
            case .tabata:
                return AppImages.WorkoutImage.tabata
            case .yoga:
                return AppImages.WorkoutImage.yoga
            }
        }()
        
        Button {
            selectedWorkout = workout
            showWorkoutDetail = true
        } label: {
            VStack(spacing: 20) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                
                Text(title)
                    .foregroundColor(.interactionDisable)
            }
            .frame(maxWidth: .infinity, minHeight: 200)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.backgroundGray.opacity(0.2))
                    .shadow(color: Color.black.opacity(0.35),
                                                radius: 10, x: 1, y: 3)
            )
        }
        .buttonStyle(ShrinkOnPressButtonStyle())
    }
}

struct ShrinkOnPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    WorksoutView()
}
