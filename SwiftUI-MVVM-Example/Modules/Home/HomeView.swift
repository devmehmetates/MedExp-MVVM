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
                    loadedState
                } else {
                    loadingState
                }
            }.navigationTitle("What's Popular")
        }.tag("Home")
    }
}

// MARK: - View Component(s)
extension HomeView {
    private var loadedState: some View {
        ScrollView {
            if let headerMediaList: [Media] = viewModel.mediaSections["Popular on TV"]?.mediaList {
                HeaderCarouselMediaList(mediaList: headerMediaList)
            }
            movieSectionStacks
        }
    }
    
    private var movieSectionStacks: some View {
        LazyVStack {
            ForEach(Array(viewModel.mediaSections.keys).sorted(), id: \.self) { sectionKey in
                if let mediaSectionValue: MediaSectionValue = viewModel.mediaSections[sectionKey] {
                    MediaListSection(mediaList: mediaSectionValue.mediaList, sectionTitle: sectionKey, mediaType: mediaSectionValue.type) {
                        viewModel.increasePage(withSectionKey: sectionKey)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
