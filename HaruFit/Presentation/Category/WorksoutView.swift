//
//  WorksoutView.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

struct WorksoutView: View {
    @StateObject private var viewModel: WorksoutViewModel = DIContainer.shared.makeWorksoutViewModel()
    @State private var showExersiseInput = false

    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // 상단 고정 헤더
                HeaderView()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        HCalendarView(viewModel: HCalendarViewModel())
                            .padding(.vertical, 10)

                        // 오늘의 운동
                        HStack(alignment: .bottom) {
                            HeaderTextView(
                                title: "오늘의 운동",
                                subTitle: nil
                            )

                            Spacer()

                            Text(Date().formattedKoreanString)
                                .b1()
                                .foregroundColor(.interactionInactive)
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal)

                        // 운동 선택(웨이트/런닝 등)
                        HStack(spacing: 10) {
                            workoutButton(title: "웨이트 트레이닝", type: .weightTraining)
                            workoutButton(title: "런닝", type: .running)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 25)

                        // 운동 기록하기
                        HStack(alignment: .bottom) {
                            HeaderTextView(
                                title: "운동 기록하기",
                                subTitle: nil
                            )

                            Button {
                                withAnimation {
                                    showExersiseInput = true
                                }
                            } label: {
                                HStack(spacing: 3) {
                                    Text("기록 추가")
                                    Image(systemName: "plus")
                                }
                                .b1()
                                .foregroundColor(.accent)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)

                        if viewModel.todayRecords.isEmpty {
                            ContentsCardView(
                                icon: AppImages.WorkoutImage.weightTraining,
                                mainTitle: "아직 등록된 운동이 없어요.",
                                subTitle: "우측 상단을 눌러 추가해주세요."
                            )
                            .padding(.horizontal)
                        } else {
                            ForEach(viewModel.todayRecords) { record in
                                ContentsCardView(
                                    icon: AppImages.WorkoutImage.weightTraining,
                                    mainTitle: record.exerciseName,
                                    subTitle: record.date.formattedKoreanString
                                )
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .overlay(
            Group {
                if showExersiseInput {
                    ExerciseInputView { selectedExercise in
                        if !selectedExercise.isEmpty {
                            viewModel.addRecord(exerciseName: selectedExercise)
                        }
                        withAnimation(.easeInOut) {
                            showExersiseInput = false
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.80)
                    .background(Color.backgroundGray)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showExersiseInput)
                }
            },
            alignment: .bottom
        )
    }

    private func workoutButton(title: String, type: WorkoutType) -> some View {
        Button {
            viewModel.selectedWorkout = type
        } label: {
            VStack(spacing: 20) {
                Image(type == .weightTraining ? AppImages.WorkoutImage.weightTraining :
                      AppImages.WorkoutImage.running)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)

                Text(title)
                    .b1()
                    .foregroundColor(.interactionDisable)
            }
            .frame(maxWidth: .infinity, minHeight: 200)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(type == viewModel.selectedWorkout
                          ? Color.backgroundGray
                          : Color.backgroundGray.opacity(0.5))
            )
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WorksoutView()
}
