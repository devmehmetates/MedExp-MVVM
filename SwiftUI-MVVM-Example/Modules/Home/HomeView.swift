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
                        ScrollView {
                            HeaderCarouselMovieList(movieList: viewModel.topRatedMovieBackdropList)
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
                } else {
                    createLoadingState()
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
