//
//  SearchView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct SearchView<Model>: View where Model: SearchViewModelProtocol {
    @ObservedObject var viewModel: Model
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(zip(viewModel.searchList.indices, viewModel.searchList)), id: \.0) { index, movie in
                    SearchMovieCardView(destination: AnyView(VStack { }), backdropPath: movie.backdropImage, imagePath: movie.posterImage, title: movie.title, overview: movie.overview, year: movie.releaseYear)
                        .onAppear {
                            viewModel.setPage(index)
                        }
                }
            }.navigationTitle("Search")
                .listStyle(.plain)
                .searchable(text: $viewModel.searchKey)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}

struct SearchMovieCardView: View {
    @Environment(\.colorScheme) var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
    
    let destination: AnyView
    let backdropPath: String
    let imagePath: String
    let title: String
    let overview: String
    let year: String
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                AnimatedAsyncImageView(path: imagePath)
                    .frame(width: 30.0.responsizeW)
                    .padding(.trailing, 1.0.responsizeW)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3)
                        .lineLimit(2)
                    Text("(\(year))")
                        Spacer()
                    Text(overview)
                        .font(.caption)
                        .lineLimit(6)
                    Spacer()
                }
                
            }.frame(height: 45.0.responsizeW)
            
        }.listRowBackground (AnimatedAsyncImageView(path: backdropPath, cornerRadius: 0)
            .overlay {
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .opacity(0.8)
            })
    }
}

