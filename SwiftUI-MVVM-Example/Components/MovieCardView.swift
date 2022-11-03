//
//  MovieCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 2.11.2022.
//

import SwiftUI
import SwiftUIAnimatedRingCharts

struct MovieCardView: View {
    // MARK: Computed variable(s)
    @Environment(\.colorScheme) private var colorScheme
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    private var contentPointColor: Color {
        point < 50 ? .red : point < 80 ? .yellow : .green
    }
    
    private var contentPointColorSecond: Color {
        contentPointColor.opacity(0.4)
    }
    
    // MARK: Extended variable(s)
    let title: String
    let point: CGFloat
    let imagePath: String
    
    var body: some View {
        VStack {
            VStack {
                AnimatedAsyncImageView(path: imagePath)
                HStack {
                    Text(title)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.bold)
                        .font(.caption2)
                    Spacer()
                    ZStack {
                        RingChartsView(values: [point], colors: [[contentPointColor, contentPointColorSecond]], ringsMaxValue: 100, lineWidth: 1.2.responsizeW)
                            .frame(width: 11.0.responsizeW, height: 11.0.responsizeW)
                        Text("%\(point.formatted())")
                            .font(.caption2)
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
                    .shadow(color: .gray.opacity(0.3), radius: 8)
            )
    }
    
    func createLinearGradient() -> LinearGradient {
        LinearGradient(colors: [.clear, backgroundColor.opacity(0.2), backgroundColor.opacity(0.5), backgroundColor.opacity(0.8)], startPoint: .top, endPoint: .bottom)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(title: "The Purge (2018)", point: 69, imagePath: AppConstants.shared.exampleImagePath)
    }
}
