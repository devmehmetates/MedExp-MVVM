//
//  SearchView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchKey: String = ""
    @State private var searchList: [Movie] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchList) { movie in
                    SearchMovieCardView(destination: AnyView(VStack { }), backdropPath: movie.backdropImage, imagePath: movie.posterImage, title: movie.title, overview: movie.overview, year: "2021")
                }
            }.navigationTitle("Search")
                .searchable(text: $searchKey)
                .onChange(of: searchKey) { newKey in
                    Task {
                        DispatchQueue.main.async {
                            let url = NetworkManager.shared.createRequestURL(ApiEndpoints.search.rawValue, page: 1, query: newKey)
                            NetworkManager.shared.apiRequest(endpoint: url) { response in
                                switch response {
                                    
                                case .success(let data):
                                    guard let decodedData: MovieList = data.decodedModel() else { return }
                                    self.searchList = decodedData.movieList
                                case .failure(let err):
                                    print(err)
                                }
                            }
                        }
                    }
                }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
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
