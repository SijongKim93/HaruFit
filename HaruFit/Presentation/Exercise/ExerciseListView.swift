//
//  ExerciseListView.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel: WeightTrainingRecordViewModel
    @State private var showPicker = false
    
    var body: some View {
        VStack {
            AddExerciseButton(showExercisePicker: $showPicker)
                .sheet(isPresented: $showPicker) {
                    ExercisePickerView(
                        exercise: viewModel.availableExercises(),
                        onSelect: viewModel.addExercise
                    )
                }
            
            ForEach($viewModel.selectedExercises) { $exercise in
                ExerciseDetailView(exercise: $exercise)
            }
        }
    }
}

struct AddExerciseButton: View {
    @Binding var showExercisePicker: Bool
    
    var body: some View {
        Button {
            showExercisePicker = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                    .frame(height: 150)
                
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(.accent)
        }
    }
}

struct ExercisePickerView: View {
    let exercise: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        NavigationView {
            List(exercise, id: \.self) { exercise in
                Button(exercise) { onSelect(exercise) }
            }
            .navigationTitle("운동 선택")
        }
    }
}

struct ExerciseDetailView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .h1()
                .foregroundColor(.interactionDisable)
            
        }
    }
}
