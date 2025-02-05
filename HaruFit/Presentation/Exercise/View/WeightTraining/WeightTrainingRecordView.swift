//
//  WeightTrainingRecordView.swift
//  HaruFit
//
//  Created by 김시종 on 1/28/25.
//

import SwiftUI

struct WeightTrainingRecordView: View {
    @StateObject var viewModel: WeightTrainingRecordViewModel
    
    init(bodyPart: BodyPart) {
        let repository = DefaultExerciseRepository()
        let useCase = DefaultExerciseUseCase(repository: repository)
        _viewModel = StateObject(wrappedValue:
                                    WeightTrainingRecordViewModel(
                                        bodyPart: bodyPart,
                                        exerciseUseCase: useCase
                                    )
        )
    }
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack {
                HeaderTextView(title: "오늘의 헬스", subTitle: "오늘 진행한 운동을 선택해주세요.")

                ExerciseListView(viewModel: viewModel)
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    WeightTrainingRecordView(bodyPart: .chest)
}
