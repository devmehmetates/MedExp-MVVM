//
//  DetailViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import Foundation

protocol DetailViewModelProtocol: ObservableObject {
    var mediaDetail: Media? { get }
    var mediaActors: [Actor] { get }
    var mediaVideos: [MediaVideos] { get }
    var recommendedMedia: [Media] { get }
    var mediaType: MediaTypes { get }
    
    func handleMediaDetail()
}

class DetailViewModel: DetailViewModelProtocol {
    @Published var mediaDetail: Media?
    @Published var mediaActors: [Actor] = []
    @Published var mediaVideos: [MediaVideos] = []
    @Published var recommendedMedia: [Media] = []
    
    var mediaId: Int
    var mediaType: MediaTypes
    
    init(mediaId: Int, mediaType: MediaTypes) {
        self.mediaId = mediaId
        self.mediaType = mediaType
        handleMediaDetail()
    }
    
    func handleMediaDetail() {
        let endpoint: String = mediaType == .tvShow ? ApiEndpoints.tvShowDetail.rawValue : ApiEndpoints.movieShowDetail.rawValue
        
        let url = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [String(mediaId)])
        
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
        
        let actorsUrl = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            mediaType == .tvShow ? "aggregate_credits" : "credits"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: actorsUrl) { response in
            switch response {
            case .success(let data):
                guard let decodedData: ActorList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaActors = decodedData.actorList
                }
            case .failure:
                print("err")
            }
        }
        
        let videosUrl = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "videos"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: videosUrl) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MediaVideoList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.mediaVideos = decodedData.mediaVideoList
                }
            case .failure:
                print("err")
            }
        }
        
        let recommendedURL = NetworkManager.shared.createRequestURL(endpoint, pathVariables: [
            String(mediaId),
            "recommendations"
        ])
        
        NetworkManager.shared.apiRequest(endpoint: recommendedURL) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MediaList = data.decodedModel() else { return }
                DispatchQueue.main.async {
                    self.recommendedMedia = decodedData.mediaList
                }
            case .failure:
                print("err")
            }
        }
    }
}
