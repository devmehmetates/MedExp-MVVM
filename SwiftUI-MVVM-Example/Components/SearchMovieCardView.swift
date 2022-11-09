//
//  SearchMovieCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct SearchMovieCardView: View {
    @Environment(\.colorScheme) var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
    
    let destination: AnyView
    let movie: Movie
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                AnimatedAsyncImageView(path: movie.posterImage)
                    .frame(width: 30.0.responsizeW)
                    .padding(.trailing, 1.0.responsizeW)
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title3)
                        .lineLimit(2)
                    Text("(\(movie.releaseYear))")
                        Spacer()
                    Text(movie.overview)
                        .font(.caption)
                        .lineLimit(6)
                    Spacer()
                }
                
            }.frame(height: 45.0.responsizeW)
            
        }.listRowBackground (AnimatedAsyncImageView(path: movie.backdropImage, cornerRadius: 0)
            .overlay {
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .opacity(0.8)
            })
    }
}
