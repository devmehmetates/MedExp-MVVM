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
                ForEach(Array(zip(viewModel.searchList.indices, viewModel.searchList)), id: \.0) { index, media in
                    SearchMediaCardView(media: media)
                        .onAppear {
                            viewModel.setPage(index)
                        }
                }
            }.navigationTitle("Search")
                .listStyle(.plain)
                .searchable(text: $viewModel.searchKey)
                .disableAutocorrection(true)
                .keyboardType(.namePhonePad)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}

