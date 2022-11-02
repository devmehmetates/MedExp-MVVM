//
//  MovieCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 2.11.2022.
//

import SwiftUI

struct MovieCardView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                AnimatedAsyncImageView(path: "https://beatroutemedia.com/wp-content/uploads/2021/04/Tate-McRae-BeatRoute-1-1.jpg")
                Rectangle()
                    .cornerRadius(10.0)
                    .foregroundStyle(createLinearGradient())
                Text("Tate mcrae")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(.callout)
                    .fontWeight(.bold)
                    .padding(.bottom)
            }.frame(width: 40.0.responsizeW, height: 60.0.responsizeW)
        }.shadow(color: .gray.opacity(0.3), radius: 10)
    }
    
    func createLinearGradient() -> LinearGradient {
        LinearGradient(colors: [.clear, backgroundColor.opacity(0.5), backgroundColor.opacity(0.75), backgroundColor.opacity(0.9)], startPoint: .top, endPoint: .bottom)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView()
    }
}

struct AnimatedAsyncImageView: View {
    let path: String
    private var url: URL? {
        URL(string: path)
    }
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .clipped()
                } else if phase.error != nil {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(.ultraThickMaterial)
                        Image(systemName: "xmark")
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(.ultraThickMaterial)
                }
            }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                .cornerRadius(10.0)
        }
    }
}

extension Double {
    var responsizeW: Double { return UIScreen.main.bounds.size.width * self / 100 }
    var responsizeH: Double { return UIScreen.main.bounds.size.height * self / 100 }
}
