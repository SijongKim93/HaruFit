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
                HeaderText()
                
            }
        }
    }
}

struct HeaderText: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 헬스")
                .h1()
                .foregroundColor(.interactionDisable)
            Text("오늘 진행한 운동을 선택해주세요.")
                .b1()
                .foregroundColor(.interactionInactive)
        }
    }
}
