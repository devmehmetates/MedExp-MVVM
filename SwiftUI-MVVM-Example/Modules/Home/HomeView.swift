//
//  HomeView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct HomeView<Model>: View where Model: HomeViewModelProtocol {
    @ObservedObject var viewModel: Model
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isPageLoaded {
                    VStack(spacing: 0) {
                        ScrollView {
                            TabView {
                                ForEach(viewModel.topRatedMovieBackdropList, id: \.id) { movie in
                                    AnimatedAsyncImageView(path: movie.backdropImage)
                                }
                            }.tabViewStyle(.page)
                                .frame(width: 92.0.responsizeW, height: 40.0.responsizeW)
                                .cornerRadius(10)
                                .padding(.bottom)
                            MovieListSection(movieList: viewModel.topRatedMovieList, sectionTitle: "Top Rated") {
                                viewModel.setpageCountForTopRatedMovieList()
                            }
                            MovieListSection(movieList: viewModel.onTVMovieList, sectionTitle: "On TV") {
                                viewModel.setpageCountForOnTVMovieList()
                            }
                            MovieListSection(movieList: viewModel.discoverMovieList, sectionTitle: "Movies") {
                                viewModel.setpageCountForDiscoverMovieList()
                            }
                        }
                    }
                } else {
                    VStack {
                        ProgressView()
                    }
                }
            }.navigationTitle("What's Popular")
        }.tag("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
