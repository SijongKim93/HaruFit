import SwiftUI

struct WorksoutView: View {
    @StateObject private var viewModel: WorksoutViewModel = DIContainer.shared.makeWorksoutViewModel()
    @State private var showExerciseInput = false

    var body: some View {
        ZStack {
            Color.backgroundBlack.ignoresSafeArea()

            VStack(spacing: 0) {
                // 상단 고정 헤더
                HeaderView()

                mainContent
            }
        }
        .onAppear {
            viewModel.loadTodayRecords()
        }
        .overlay(overlayDimBackground, alignment: .bottom)
        .overlay(overlayExerciseInput, alignment: .bottom)
        .animation(.easeInOut(duration: 0.3), value: showExerciseInput)
        .navigationBarHidden(true)
    }

    // MARK: - Main Content
    private var mainContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HCalendarView(viewModel: HCalendarViewModel())
                    .padding(.vertical, 10)

                headerWithDateSection
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                workoutSelectionSection
                    .padding(.horizontal)
                    .padding(.bottom, 25)

                exerciseRecordSection
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                Spacer()
            }
        }
    }

    // MARK: - Sections
    private var headerWithDateSection: some View {
        HStack(alignment: .bottom) {
            HeaderTextView(title: "오늘의 운동", subTitle: nil)
            Spacer()
            Text(Date().formattedKoreanString)
                .b1()
                .foregroundColor(.interactionInactive)
        }
    }

    private var workoutSelectionSection: some View {
        HStack(spacing: 10) {
            workoutButton(title: "웨이트 트레이닝", type: .weightTraining)
            workoutButton(title: "런닝", type: .running)
        }
    }

    private var exerciseRecordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .bottom) {
                HeaderTextView(title: "운동 기록하기", subTitle: nil)
                Spacer()
                Button {
                    withAnimation {
                        showExerciseInput = true
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

            if viewModel.todayRecords.isEmpty {
                NoDataView()
            } else {
                ForEach(viewModel.todayRecords) { record in
                    ContentsCardView(
                        icon: AppImages.WorkoutImage.weightTraining,
                        mainTitle: record.exerciseName,
                        subTitle: record.date.formattedKoreanString,
                        onButtonTap: { viewModel.deleteRecord(record: record) }
                    )
                }
            }
        }
    }

    // MARK: - Workout Button
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
    }

    // MARK: - Overlays
    private var overlayDimBackground: some View {
        Group {
            if showExerciseInput {
                Color.backgroundBlack.opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showExerciseInput = false
                        }
                    }
                    .transition(.opacity)
            }
        }
    }

    private var overlayExerciseInput: some View {
        Group {
            if showExerciseInput {
                ExerciseInputView { selectedExercise in
                    if !selectedExercise.isEmpty {
                        viewModel.addRecord(exerciseName: selectedExercise)
                    }
                    withAnimation(.easeInOut) {
                        showExerciseInput = false
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.60)
                .background(Color.backgroundGray)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
                .transition(.move(edge: .bottom))
            }
        }
    }
}

#Preview {
    WorksoutView()
}
