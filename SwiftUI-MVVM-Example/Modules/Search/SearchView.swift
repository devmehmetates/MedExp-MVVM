//
//  SearchView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct SearchView<Model>: View where Model: SearchViewModelProtocol {
    private let columns: [GridItem] = [.init(.fixed(45.0.responsizeW)), .init(.fixed(45.0.responsizeW))]
    @ObservedObject var viewModel: Model
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Array(zip(viewModel.searchList.indices, viewModel.searchList)), id: \.0) { index, media in
                        SearchMediaCardView(media: media)
                            .onAppear {
                                viewModel.setPage(index)
                            }
                    }
                }
            }.navigationTitle("Search")
                .searchable(text: $viewModel.searchKey)
                .disableAutocorrection(true)
                .keyboardType(.namePhonePad)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchViewModel()
        SearchView(viewModel: viewModel)
            .onAppear {
                viewModel.searchKey = "Titanic"
            }
    }
}

