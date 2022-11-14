//
//  DetailViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import Foundation

protocol DetailViewModelProtocol: ObservableObject {
    var mediaDetailValue: DetailViewModelValues { get }
    var isPageLoaded: Bool { get }
}

class DetailViewModel: DetailViewModelProtocol {
    @Published var mediaDetailValue: DetailViewModelValues = DetailViewModelValues()
    @Published var isPageLoaded: Bool = false
    
    var mediaId: Int
    var mediaType: MediaTypes
    
    init(mediaId: Int, mediaType: MediaTypes) {
        self.mediaId = mediaId
        self.mediaType = mediaType
        handleMedia()
    }
    
    func handleMedia() {
        let endpoint: String = mediaType == .tvShow ? ApiEndpoints.tvShowDetail.rawValue : ApiEndpoints.movieShowDetail.rawValue
        handleMediaDetail(endpoint)
        handleMediaActors(endpoint)
        handleMediaVideos(endpoint)
        handleRecommendedMedia(endpoint)
    }
    
    func handleMediaDetail(_ endpoint: String) {
        let url = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [String(mediaId)])
        
        NetworkManager.shared.apiRequest(endpoint: url) { response in
            switch response {
            case .success(let data):
                guard let decodedData: Media = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaDetailValue.mediaDetail = decodedData
                    self.isPageLoaded = true
                }
            case .failure:
                print("err")
            }
        }
    }
    
    func handleMediaActors(_ endpoint: String) {
        let actorsUrl = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            mediaType == .tvShow ? "aggregate_credits" : "credits"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: actorsUrl) { response in
            switch response {
            case .success(let data):
                guard let decodedData: ActorList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaDetailValue.mediaActors = decodedData.actorList
                }
            case .failure:
                print("err")
            }
        }
    }
    
    func handleMediaVideos(_ endpoint: String) {
        let videosUrl = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "videos"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: videosUrl) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MediaVideoList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaDetailValue.mediaVideos = decodedData.mediaVideoList
                }
            case .failure:
                print("err")
            }
        }
    }
    
    func handleRecommendedMedia(_ endpoint: String) {
        let recommendedURL = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "recommendations"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: recommendedURL) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MediaList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaDetailValue.recommendedMedia = decodedData.mediaList
                }
            case .failure:
                print("err")
            }
        }
    }
}

struct DetailViewModelValues {
    var mediaDetail: Media
    var mediaActors: [Actor]
    var mediaVideos: [MediaVideos]
    var recommendedMedia: [Media]
    var mediaType: MediaTypes
    
    init() {
        self.mediaDetail = Media()
        self.mediaActors = []
        self.mediaVideos = []
        self.recommendedMedia = []
        self.mediaType = .movie
    }
}
