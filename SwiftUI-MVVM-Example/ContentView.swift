//
//  ContentView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 1.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: String = "Home"
    @State private var movieList: [Movie] = []
    @State private var movieList2: [Movie] = []
    @State private var movieList3: [Movie] = []
    
    var body: some View {
        TabView(selection: $currentTab) {
            NavigationView {
                VStack(spacing: 0) {
                    ScrollView {
                        TabView {
                            AnimatedAsyncImageView(path: AppConstants.shared.exampleBackdropImagePath)
                            AnimatedAsyncImageView(path: AppConstants.shared.exampleImagePath)
                        }.tabViewStyle(.page)
                            .frame(width: 92.0.responsizeW, height: 40.0.responsizeW)
                            .cornerRadius(10)
                            .padding(.bottom)
                        MovieListSection(movieList: movieList3, sectionTitle: "Top Rated")
                        MovieListSection(movieList: movieList, sectionTitle: "On TV")
                        MovieListSection(movieList: movieList2, sectionTitle: "Movies")
                    }
                }.navigationTitle("What's Popular")
                    .onAppear {
                        Task {
                            DispatchQueue.main.async {
                                NetworkManager.shared.apiRequest(endpoint: NetworkManager.shared.createRequestURL(ApiEndpoints.discoverTV.rawValue, page: 1)) { response in
                                    switch response {
                                    case .success(let data):
                                        guard let movieListResponse: MovieList = data.decodedModel() else { return }
                                        movieList = movieListResponse.movieList
                                    case .failure:
                                        print("Error")
                                    }
                                }
                                
                                NetworkManager.shared.apiRequest(endpoint: NetworkManager.shared.createRequestURL(ApiEndpoints.discoverMovie.rawValue, page: 1)) { response in
                                    switch response {
                                    case .success(let data):
                                        guard let movieListResponse: MovieList = data.decodedModel() else { return }
                                        movieList2 = movieListResponse.movieList
                                    case .failure:
                                        print("Error")
                                    }
                                }
                                
                                NetworkManager.shared.apiRequest(endpoint: NetworkManager.shared.createRequestURL(ApiEndpoints.topRatedTV.rawValue, page: 1)) { response in
                                    switch response {
                                    case .success(let data):
                                        guard let movieListResponse: MovieList = data.decodedModel() else { return }
                                        movieList3 = movieListResponse.movieList
                                    case .failure:
                                        print("Error")
                                    }
                                }

                            }
                        }
                    }
            }.tag("Home")
            NavigationView {
                VStack {

                }.navigationTitle("Search")
            }.tag("Search")
        }.overlay(alignment: .bottom) {
            HStack {
                Button {
                    withAnimation {
                        currentTab = "Home"
                    }
                } label: {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                            .fontWeight(.bold)
                    }.frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == "Home" ? .primary : .secondary)
                }
                
                Button {
                    withAnimation {
                        currentTab = "Search"
                    }
                } label: {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                            .fontWeight(.bold)
                    }.frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == "Search" ? .primary : .secondary)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieListSection: View {
    let movieList: [Movie]
    let sectionTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0.responsizeW) {
            Text(sectionTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 5.0.responsizeW)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movieList, id: \.id) { movie in
                        MovieCardView(title: movie.title, point: movie.point, imagePath: movie.posterImage)
                    }
                }.padding([.horizontal, .bottom])
            }
        }
    }
}

struct Movie: Codable, Identifiable {
    let id: Double
    private let originalName: String?
    private let originalTitle: String?
    private let voteAverage: Double?
    private let backdropPath: String?
    private let posterPath: String?
    
    var posterImage: String { NetworkManager.shared.createimageUrl(withPath: posterPath) }
    var backdropImage: String { NetworkManager.shared.createimageUrl(withPath: backdropPath) }
    var title: String { originalName ?? originalTitle ?? "Unknowed"}
    var point: CGFloat { (voteAverage ?? 0) * 10 }
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

struct MovieList: Codable {
    private let results: [Movie]?
    var movieList: [Movie] { results ?? [] }
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
