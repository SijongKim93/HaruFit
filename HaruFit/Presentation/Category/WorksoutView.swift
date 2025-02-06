//
//  WorksoutView.swift
//  HaruFit
//
//  Created by 김시종 on 1/8/25.
//

import SwiftUI

struct WorksoutView: View {
    @StateObject private var viewModel: WorksoutViewModel

    init() {
        // 간단 DI
        let repo = InMemoryWorkoutRepository()
        let fetchUC = DefaultFetchTodayRecordsUseCase(repository: repo)
        let addUC = DefaultAddRecordUseCase(repository: repo)
        _viewModel = StateObject(wrappedValue: WorksoutViewModel(
            fetchTodayRecordsUseCase: fetchUC,
            addRecordUseCase: addUC
        ))
    }

    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // 상단 고정 헤더
                HeaderView()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // 캘린더
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
                        // 만약 user가 누르면 selectedWorkout 바꿀 수도, 여기선 기본값
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
                                subTitle: "오늘 진행한 운동을 기록해주세요."
                            )
                            
                            Button {
                                viewModel.addRecord(exerciseName: "벤치")
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
                            ContentsCardView(icon: AppImages.WorkoutImage.weightTraining, mainTitle: "아직 등록된 운동이 없어요.", subTitle: "우측 상단을 눌러 추가해주세요.")
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
    }

    // 간단 날짜 포맷
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

    // 운동 타입 버튼
    private func workoutButton(title: String, type: WorkoutType) -> some View {
        Button {
            // 탭하면 selectedWorkout을 바꿈
            viewModel.selectedWorkout = type
        } label: {
            VStack(spacing: 20) {
                // 단순 아이콘 예시
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
    }
}

#Preview {
    WorksoutView()
}
