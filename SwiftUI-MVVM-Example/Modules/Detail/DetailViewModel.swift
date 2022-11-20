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
    private var manager: NetworkManagerProtocol!
    
    init(mediaId: Int, mediaType: MediaTypes, manager: NetworkManagerProtocol? = nil) {
        self.manager = manager ?? NetworkManager()
        self.mediaId = mediaId
        self.mediaType = mediaType
        handleMedia()
    }
    
    private func handleMedia() {
        let endpoint: String = mediaType == .tvShow ? ApiEndpoints.tvShowDetail.rawValue : ApiEndpoints.movieShowDetail.rawValue
        handleMediaDetail(endpoint)
        handleMediaActors(endpoint)
        handleMediaVideos(endpoint)
        handleRecommendedMedia(endpoint)
    }
    
    private func handleMediaDetail(_ endpoint: String) {
        let url = manager.createRequestURL(endpoint, pathVariables: [String(mediaId)], headerParams: nil)
        
        manager.apiRequest(endpoint: url, param: nil) { response in
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
    
    private func handleMediaActors(_ endpoint: String) {
        let actorsUrl = manager.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            mediaType == .tvShow ? "aggregate_credits" : "credits"
        ], headerParams: nil)
        
        manager.apiRequest(endpoint: actorsUrl, param: nil) { response in
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
    
    private func handleMediaVideos(_ endpoint: String) {
        let videosUrl = manager.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "videos"
        ], headerParams: nil)
        
        manager.apiRequest(endpoint: videosUrl, param: nil) { response in
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
    
    private func handleRecommendedMedia(_ endpoint: String) {
        let recommendedURL = manager.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "recommendations"
        ], headerParams: nil)
        
        manager.apiRequest(endpoint: recommendedURL, param: nil) { response in
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
