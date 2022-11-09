//
//  HeaderCarouselMovieList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct HeaderCarouselMovieList: View {
    @Environment(\.colorScheme) private var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .black.opacity(0.9) : .white.opacity(0.9) }
    let movieList: [Movie]
    
    var body: some View {
        TabView {
            ForEach(movieList, id: \.id) { movie in
                NavigationLink {
                    
                } label: {
                    AnimatedAsyncImageView(path: movie.backdropImage)
                        .overlay {
                            ZStack(alignment: .topLeading) {
                                Rectangle()
                                    .foregroundStyle(LinearGradient(colors: [backgroundColor, backgroundColor.opacity(0.7), backgroundColor.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom))
                                Text(movie.title)
                                    .lineLimit(1)
                                    .font(.title2)
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                        }
                }
            }
        }.tabViewStyle(.page)
            .frame(width: 92.0.responsizeW, height: 40.0.responsizeW)
            .cornerRadius(10)
            .padding(.bottom)
    }
}
