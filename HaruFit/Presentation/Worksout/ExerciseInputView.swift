//
//  ExerciseInputView.swift
//  HaruFit
//
//  Created by 김시종 on 2/8/25.
//

import SwiftUI
import Worksout

struct ExerciseInputView: View {
    var onSelectExercise: (String, String, String) -> Void
    @State private var selectedBodyPart: BodyPart = .back
    @State private var exerciseName: String = ""
    @State private var setCount: String = "5"
    @State private var repCount: String = "12"

    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                headerTitleSection

                bodyPartSelectedSection

                exerciseSelectedSection
                .padding(.top, 10)
                .padding(.horizontal)

                setCountSection

                saveButtonSection
            }
        }
    }

    // MARK: - Header Content

    private var headerTitleSection: some View {
        HStack {
            HStack {
                Image("dumbell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                Text("운동 선택")
                    .h1()
                    .foregroundColor(Color.interactionDisable)
            }
            .padding()

            Spacer()

            Button {
                onSelectExercise("", "", "")
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.interactionDisable)
            }
            .padding()
        }
    }

    // MARK: - BodyPart

    private var bodyPartSelectedSection: some View {
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
            .padding(.top, 10)
            .padding(.horizontal)
        }
    }

    // MARK: - Exercise Selected

    private var exerciseSelectedSection: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(ExerciseResource.exercises(for: selectedBodyPart), id: \.self) { exercise in
                    Button(action: {
                        exerciseName = exercise
                    }) {
                        Text(exercise)
                            .b1()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                exerciseName == exercise ? Color.accent.opacity(0.5) : Color.backgroundGray.opacity(0.5)
                            )
                            .cornerRadius(12)
                            .foregroundColor(.interactionDisable)
                    }
                }
            }
        }
    }

    // MARK: - Set, Rep Count

    private var setCountSection: some View {
        HStack(spacing: 10) {
            HStack(spacing: 5) {
                TextField("3", text: $setCount)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 60, height: 60)
                Text("세트")
                    .b1()
                    .foregroundColor(.interactionDisable)
            }

            HStack(spacing: 5) {
                TextField("12", text: $repCount)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 60, height: 60)
                Text("회")
                    .b1()
                    .foregroundColor(.interactionDisable)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Save Button

    private var saveButtonSection: some View {
        CustomButton(
            title: "추가하기",
            size: .large,
            backgroundColor: exerciseName != "" ? .accent : .interactionInactive,
            foregroundColor: .interactionDisable,
            borderColor: nil,
            action: {
                if !exerciseName.isEmpty && !setCount.isEmpty && !repCount.isEmpty {
                    onSelectExercise(exerciseName, setCount, repCount)
                }
            }
        )
    }
}

#Preview {
    ExerciseInputView(onSelectExercise: { _,_,_  in print("tapped") })
}
