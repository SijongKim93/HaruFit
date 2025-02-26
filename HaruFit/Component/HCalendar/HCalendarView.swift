//
//  HCalendarView.swift
//  HaruFit
//
//  Created by SiJongKim on 2/5/25.
//

import SwiftUI

struct HCalendarView: View {
    @ObservedObject var viewModel: HCalendarViewModel

    private let calendar = Calendar.current
    private let today = Date().startOfDay

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                ScrollViewReader { proxy in
                    dayScroll
                        .onAppear {
                            scrollToSelectedDate(proxy: proxy)
                        }
                }
            }
            .frame(height: 80)
        }
    }

    @ViewBuilder
    private var dayScroll: some View {
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let dayCount = calendar.range(of: .day, in: .month, for: startDate)!.count

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 20)

                ForEach(0..<dayCount, id: \.self) { offset in
                    let date = calendar.date(byAdding: .day, value: offset, to: startDate)!

                    VStack(spacing: 0) {
                        Text(dayOfWeek(from: date))
                            .b2()
                        Text("\(calendar.component(.day, from: date))")
                            .b3()

                        Spacer()

                        if let count = viewModel.dailyDataCount[date], count > 0 {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.accent)
                        }
                    }
                    .frame(width: 40, height: 70)
                    .padding(4)
                    .background(calendar.isDate(date, inSameDayAs: Date()) ? Color.accent : Color.clear)
                    .cornerRadius(12)
                    .foregroundColor(calendar.isDate(date, inSameDayAs: Date()) ? .white : .gray)
                    .id(date)
                }

                Spacer()
                    .frame(width: 20)
            }
        }
    }

    private func scrollToSelectedDate(proxy: ScrollViewProxy) {
        DispatchQueue.main.async {
            proxy.scrollTo(today, anchor: .center)
        }
    }

    private func dayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        return dateFormatter.string(from: date)
    }
}
