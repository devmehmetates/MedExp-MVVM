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
                            HeaderCarouselMediaList(mediaList: viewModel.headerCarouselMediaList)
                            MediaListSection(mediaList: viewModel.onTheAirMediaList, sectionTitle: "On The Air", mediaType: .tvShow) {
                                viewModel.setpageCountForOnTheAirMediaList()
                            }
                            MediaListSection(mediaList: viewModel.topRatedMediaList, sectionTitle: "Top Rated", mediaType: .tvShow) {
                                viewModel.setpageCountForTopRatedMediaList()
                            }
                            MediaListSection(mediaList: viewModel.onTVMediaList, sectionTitle: "On TV", mediaType: .tvShow) {
                                viewModel.setpageCountForOnTVMediaList()
                            }
                            MediaListSection(mediaList: viewModel.discoverMediaList, sectionTitle: "Movies", mediaType: .movie) {
                                viewModel.setpageCountForDiscoverMediaList()
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
