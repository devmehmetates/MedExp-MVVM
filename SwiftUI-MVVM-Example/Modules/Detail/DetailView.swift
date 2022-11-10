//
//  DetailView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 10.11.2022.
//

import SwiftUI
import StickyAsyncImageSwiftUI

struct DetailView<Model>: View where Model: DetailViewModelProtocol {
    @ObservedObject var viewModel: Model
    
    var body: some View {
        Group {
            if let media = viewModel.mediaDetail {
                ScrollView {
                    StickyAsyncImageSwiftUI(url: URL(string: media.backdropImage), size: 50.0.responsizeW, coordinateSpace: "sticky")
                    VStack {
                        HStack {
                            AnimatedAsyncImageView(path: media.posterImage)
                                .frame(width: 40.0.responsizeW, height: 60.0.responsizeW)
                                .transformEffect(CGAffineTransform(1, 0, 0, 1, 0, -10.0.responsizeW))
                            VStack(alignment: .leading) {
                                Text(media.title)
                                    .lineLimit(4)
                                    .font(.system(size: 6.responsizeW, weight: .bold))
                                Text(media.releaseYear)
                                    .font(.footnote)
                                Spacer()
                            }
                            Spacer()
                        }.padding(.horizontal)
                            .frame(height: 40.0.responsizeW)
                    }
                }.coordinateSpace(name: "sticky")
                    .ignoresSafeArea(edges: .top)
                    
            } else {
                createLoadingState()
                    .onAppear {
                        viewModel.handleMediaDetail()
                    }
                    .onAppear {
                        viewModel.handleMediaDetail()
                    }
            }
        }.onAppear {
            viewModel.handleMediaDetail()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(mediaId: 95403, mediaType: .tvShow))
    }
}

protocol DetailViewModelProtocol: ObservableObject {
    var mediaDetail: Media? { get }
    func handleMediaDetail()
}

class DetailViewModel: DetailViewModelProtocol {
    @Published var mediaDetail: Media?
    
    var mediaId: Int
    var mediaType: MediaTypes
    
    init(mediaId: Int, mediaType: MediaTypes) {
        self.mediaId = mediaId
        self.mediaType = mediaType
    }
    
    func handleMediaDetail() {
        let endpoint: String = mediaType == .tvShow ? ApiEndpoints.tvShowDetail.rawValue : ApiEndpoints.movieShowDetail.rawValue
        
        let url = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [mediaId], headerParams: [
            "api_key": AppEnvironments.apiKey
        ])
        NetworkManager.shared.apiRequest(endpoint: url) { response in
            switch response {
            case .success(let data):
                guard let decodedData: Media = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaDetail = decodedData
                }
            case .failure:
                print("err")
            }
        }
    }
}
