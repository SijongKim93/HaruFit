//
//  WeightTrainingRecordView.swift
//  HaruFit
//
//  Created by 김시종 on 1/23/25.
//

import SwiftUI

struct WeightTrainingRecordView: View {
    
    @State private var selectedExercise: String? = nil
    
    @State private var isKgUnit: Bool = true
    @State private var weightValue: Int = 10
    @State private var repsValue: Int = 10
    @State private var setsValue: Int = 3
    
    @State private var showExercisePicker = false
    
    let bodyPart: BodyPart
    
    var body: some View {
        ZStack {
            Color.backgroundBlack
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("오늘의 헬스")
                    .h1()
                    .foregroundColor(.interactionDisable)
                Text("어떤 운동을 하셨는지 기록해주세요.")
                    .b1()
                    .foregroundColor(.interactionInactive)
                
                Button(
                    action: {
                        showExercisePicker = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [10, 5]))
                                .frame(height: 150)
                                                            
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30,height: 30)
                        }
                        .foregroundColor(.accent)
                    }
                )
                .padding(.top, 50)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        
    }
    
}


#Preview {
    WeightTrainingRecordView(bodyPart: .chest)
}
