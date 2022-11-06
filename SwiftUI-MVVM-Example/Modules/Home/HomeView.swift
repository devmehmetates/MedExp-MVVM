//
//  HomeView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var movieList: [Movie] = []
    @State private var movieList2: [Movie] = []
    @State private var movieList3: [Movie] = []
    
    var body: some View {
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
