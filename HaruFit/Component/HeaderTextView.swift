//
//  HeaderTextView.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

struct HeaderTextView: View {
    var title: String
    var subTitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .h1()
                .foregroundColor(.interactionDisable)

            if let subTitle = subTitle {
                Text(subTitle)
                    .b1()
                    .foregroundColor(.interactionInactive)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
