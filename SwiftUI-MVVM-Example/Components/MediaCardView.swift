//
//  MediaCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 2.11.2022.
//

import SwiftUI
import SwiftUIAnimatedRingCharts

struct MediaCardView: View, CardView {
    @Environment(\.colorScheme) private var colorScheme
    let media: Media
    
    var body: some View {
        VStack {
            VStack {
                AnimatedAsyncImageView(path: media.posterImage)
                mediaInformationStack
            }.padding(.bottom, 7)
        }.frame(width: 45.0.responsizeW, height: 85.0.responsizeW)
            .background(cardBackground(overlayLinearGradient: overlayLinearGradient, colorScheme: colorScheme))
    }
}

// MARK: View component(s)
extension MediaCardView {
    private var mediaTitle: some View {
        Text(media.title)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .font(.caption2)
            .foregroundColor(.primary)
    }
    
    private var mediaPointChartStack: some View {
        ZStack {
            RingChartsView(values: [media.point], colors: [[contentPointColor, contentPointColorSecond]], ringsMaxValue: 100, lineWidth: 1.2.responsizeW)
                .frame(width: 11.0.responsizeW, height: 11.0.responsizeW)
            Text("%\(Int(media.point).formatted())")
                .font(.caption2)
                .foregroundColor(.primary)
        }
    }
    
    private var mediaInformationStack: some View {
        HStack {
            mediaTitle
            Spacer()
            mediaPointChartStack
        }.padding(.horizontal, 11)
            .padding(.vertical, 7)
            .font(.callout)
    }
}

// MARK: Color properties
extension MediaCardView {
    private var overlayLinearGradient: LinearGradient {
        LinearGradient(
            colors: [.clear, backgroundColor.opacity(0.2), backgroundColor.opacity(0.5), backgroundColor.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    private var backgroundColor: Color { colorScheme == .dark ? .gray.opacity(0.2) : .white }
    private var contentPointColor: Color { media.point < 50 ? .red : media.point < 80 ? .yellow : .green }
    private var contentPointColorSecond: Color { contentPointColor.opacity(0.4) }
}
