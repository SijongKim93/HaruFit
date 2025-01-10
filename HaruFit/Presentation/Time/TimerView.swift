//
//  TimerView.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel: TimerViewModel
    
    init() {
        let repo = InMemoryWorkoutRepository()
        let useCase = DefaultWorkoutUseCase(repository: repo)
        _viewModel = StateObject(wrappedValue: TimerViewModel(useCase: useCase))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("HaruFit - Workout")
                .font(.title)
            
            Picker("운동 타입", selection: $viewModel.workoutType) {
                Text("웨이트 트레이닝").tag(Workout.weightTraining)
                Text("런닝").tag(Workout.running)
                Text("타바타").tag(Workout.tabata)
            }
            .pickerStyle(.segmented)
            
            // 웨이트 트레이닝
            if viewModel.workoutType == .weightTraining {
                Stepper("휴식 시간(초): \(viewModel.restTime)", value: $viewModel.restTime, in: 0...300)
                Stepper("총 세트 수: \(viewModel.totalSets)", value: $viewModel.totalSets, in: 1...20)
                Text("현재 세트: \(viewModel.currentSets)")
            }
            
            // 런닝
            if viewModel.workoutType == .running {
                Stepper("거리(km): \(viewModel.distance, specifier: "%.1f")", value: $viewModel.distance, in: 0...100, step: 0.5)
                Text("현재 런닝 시간: \(viewModel.runningTime)초")
            }
            
            // 타바타 (UI 구현 예시)
            if viewModel.workoutType == .tabata {
                Text("타바타 UI는 추후 구현...")
            }
            
            HStack(spacing: 40) {
                Button("Start") {
                    viewModel.start()
                }
                Button("Stop") {
                    viewModel.stop()
                }
            }
            
            Button("Save Setting") {
                viewModel.saveSetting()
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    TimerView()
}
