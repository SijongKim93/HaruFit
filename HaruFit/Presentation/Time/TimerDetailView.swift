//
//  TimerDetailView.swift
//  HaruFit
//
//  Created by SiJongKim on 1/15/25.
//

import SwiftUI

struct TimerDetailView: View {
    // 어떤 운동인지
    let workout: Workout

    // 뷰 종료(닫기) 시 실행할 콜백
    let onClose: () -> Void

    // 기존 TimerViewModel 재사용
    @StateObject private var viewModel: TimerViewModel

    init(workout: Workout, onClose: @escaping () -> Void) {
        // 필요한 UseCase, Repo는 여기서도 동일하게 생성하거나
        // 싱글턴/DIContainer 등에서 주입 가능
        let repo = InMemoryWorkoutRepository()
        let useCase = DefaultWorkoutUseCase(repository: repo)

        _viewModel = StateObject(wrappedValue: TimerViewModel(useCase: useCase))

        self.workout = workout
        self.onClose = onClose
    }

    var body: some View {
        VStack(spacing: 20) {
            // 상단에 닫기 버튼
            HStack {
                Spacer()
                Button(action: { onClose() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
            }

            Text("HaruFit - \(workoutTitle)")
                .font(.title)

            // 운동 타입에 맞는 UI만 표시
            switch workout {
            case .weightTraining:
                weightTrainingUI
            case .running:
                runningUI
            case .tabata:
                tabataUI
            }

            HStack(spacing: 40) {
                Button("Start") { viewModel.start() }
                Button("Stop") { viewModel.stop() }
            }

            Button("Save Setting") { viewModel.saveSetting() }

            Spacer()
        }
        .padding()
        .onAppear {
            // 운동 타입 설정
            viewModel.workoutType = workout
            viewModel.onAppear()
        }
    }

    // MARK: - Subviews

    // 웨이트 트레이닝 UI
    private var weightTrainingUI: some View {
        VStack(spacing: 16) {
            Stepper("휴식 시간(초): \(viewModel.restTime)", value: $viewModel.restTime, in: 0...300)
            Stepper("총 세트 수: \(viewModel.totalSets)", value: $viewModel.totalSets, in: 1...20)
            Text("현재 세트: \(viewModel.currentSets)")
        }
    }

    // 런닝 UI
    private var runningUI: some View {
        VStack(spacing: 16) {
            Stepper("거리(km): \(viewModel.distance, specifier: "%.1f")",
                    value: $viewModel.distance, in: 0...100, step: 0.5)
            Text("현재 런닝 시간: \(viewModel.runningTime)초")
        }
    }

    // 타바타 UI
    private var tabataUI: some View {
        Text("타바타 UI는 추후 구현...")
    }

    // 운동 타입별 제목
    private var workoutTitle: String {
        switch workout {
        case .weightTraining: return "웨이트 트레이닝"
        case .running:        return "런닝"
        case .tabata:         return "타바타"
        }
    }
}

#Preview {
    TimerDetailView(workout: .weightTraining) {
    }
}
