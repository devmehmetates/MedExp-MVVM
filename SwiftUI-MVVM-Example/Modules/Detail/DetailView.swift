//
//  DetailView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 10.11.2022.
//

import SwiftUI

struct DetailView<Model>: View where Model: DetailViewModelProtocol {
    @ObservedObject var viewModel: Model
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(mediaId: 95403, mediaType: .tvShow))
    }
}

protocol DetailViewModelProtocol: ObservableObject { }

class DetailViewModel: DetailViewModelProtocol {
    var mediaId: Int
    var mediaType: MediaTypes
    
    init(mediaId: Int, mediaType: MediaTypes) {
        self.mediaId = mediaId
        self.mediaType = mediaType
    }
}
