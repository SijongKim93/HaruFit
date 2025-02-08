//
//  ContentsCardView.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

struct ContentsCardView: View {
    let icon: String
    let mainTitle: String
    let subTitle: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.backgroundGray.opacity(0.5))

            HStack(spacing: 16) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 4) {
                    Text(mainTitle)
                        .b2()
                        .foregroundColor(.interactionDisable)

                    Text(subTitle)
                        .b5()
                        .foregroundColor(.interactionInactive)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentsCardView(icon: AppImages.WorkoutImage.weightTraining, mainTitle: "벤치프레스", subTitle: "3세트 12회")
}
