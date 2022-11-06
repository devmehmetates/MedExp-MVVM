//
//  MovieListSection.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct MovieListSection: View {
    let movieList: [Movie]
    let sectionTitle: String
    var cardOnAppear: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0.responsizeW) {
            Text(sectionTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 5.0.responsizeW)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(zip(movieList.indices, movieList)), id: \.1.id) { index, movie in
                        MovieCardView(title: movie.title, point: movie.point, imagePath: movie.posterImage)
                            .onAppear {
                                if index == movieList.count - 3 {
                                    cardOnAppear?()
                                }
                            }
                    }
                }.padding([.horizontal, .bottom])
            }
        }
    }
}

struct MovieListSection_Previews: PreviewProvider {
    static var previews: some View {
        MovieListSection(movieList: [], sectionTitle: "On TV") {
            
        }
    }
}
