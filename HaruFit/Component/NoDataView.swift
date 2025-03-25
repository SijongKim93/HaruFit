//
//  NoDataView.swift
//  HaruFit
//
//  Created by 김시종 on 2/26/25.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.backgroundGray.opacity(0.5))
            
            HStack(spacing: 20) {
                Image("inform")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("등록된 기록이 없어요")
                        .h2()
                        .foregroundColor(.interactionDisable)
                    
                    Text("오늘 진행한 운동을 추가해주세요")
                        .b1()
                        .foregroundColor(.interactionDisable.opacity(0.5))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
}

#Preview {
    NoDataView()
}
