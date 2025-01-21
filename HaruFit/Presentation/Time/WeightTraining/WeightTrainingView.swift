//
//  WeightTrainingView.swift
//  HaruFit
//
//  Created by 김시종 on 1/21/25.
//

import SwiftUI

struct WeightTrainingView: View {
    @StateObject private var viewModel: WeightTrainingViewModel
    
    init() {
        let repo = InMemoryWorkoutRepository()
        let useCase = DefaultWorkoutUseCase(repository: repo)
        _viewModel = StateObject(wrappedValue: WeightTrainingViewModel(useCase: useCase))
    }
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("WeightTraining")
                    .h1()
                    .foregroundColor(.interactionDisable)
                
                Stepper("휴식 시간(초): \(viewModel.restTime)",
                        value: $viewModel.restTime,
                        in: 0...300)
                .foregroundColor(.interactionDisable)
                
                Stepper("총 세트 수: \(viewModel.totalSets)",
                        value: $viewModel.totalSets,
                        in: 1...30)
                .foregroundColor(.interactionDisable)
                
                circleTimerView
                
                Text("현재 세트: \(viewModel.currentSets)")
                    .foregroundColor(.interactionDisable)
                
                HStack(spacing: 40) {
                    Button(action: {
                        viewModel.start()
                    }, label: {
                        Text("Start")
                    })
                    .foregroundColor(.interactionDisable)
                    
                    Button(action: {
                        viewModel.stop()
                    }, label: {
                        Text("Stop")
                    })
                    .foregroundColor(.interactionDisable)
                }
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var circleTimerView: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12)
                .foregroundColor(.accentColor)
                .frame(width: 180, height: 180)
            
            Circle()
                .trim(from: 0, to: viewModel.timerFraction)
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .foregroundColor(.accent)
                .rotationEffect(.degrees(-90))
                .frame(width: 180, height: 180)
                .animation(.easeInOut(duration: 0.5), value: viewModel.timerFraction)
            
            Text("\(viewModel.remainingTime) s")
                .b1()
                .foregroundColor(.interactionDisable)
        }
    }
}

#Preview {
    WeightTrainingView()
}
