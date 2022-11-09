//
//  MediaCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 2.11.2022.
//

import SwiftUI
import SwiftUIAnimatedRingCharts

struct MediaCardView: View {
    // MARK: Computed variable(s)
    @Environment(\.colorScheme) private var colorScheme
    private var backgroundColor: Color {
        colorScheme == .dark ? .gray.opacity(0.2) : .white
    }
    private var contentPointColor: Color {
        media.point < 50 ? .red : media.point < 80 ? .yellow : .green
    }
    
    private var contentPointColorSecond: Color {
        contentPointColor.opacity(0.4)
    }
    
    // MARK: Extended variable(s)
    let media: Media
    
    var body: some View {
        VStack {
            VStack {
                AnimatedAsyncImageView(path: media.posterImage)
                HStack {
                    Text(media.title)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .font(.caption2)
                        .foregroundColor(.primary)
                    Spacer()
                    ZStack {
                        RingChartsView(values: [media.point], colors: [[contentPointColor, contentPointColorSecond]], ringsMaxValue: 100, lineWidth: 1.2.responsizeW)
                            .frame(width: 11.0.responsizeW, height: 11.0.responsizeW)
                        Text("%\(media.point.formatted())")
                            .font(.caption2)
                            .foregroundColor(.primary)
                    }
                }.padding(.horizontal, 11)
                    .padding(.vertical, 7)
                    .font(.callout)
            }.padding(.bottom, 7)
        }.frame(width: 45.0.responsizeW, height: 80.0.responsizeW)
            .background(
                Rectangle()
                    .foregroundStyle(createLinearGradient())
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: colorScheme == .dark ? 0 : 8)
            )
    }
    
    func createLinearGradient() -> LinearGradient {
        LinearGradient(colors: [.clear, backgroundColor.opacity(0.2), backgroundColor.opacity(0.5), backgroundColor.opacity(0.8)], startPoint: .top, endPoint: .bottom)
    }
}
