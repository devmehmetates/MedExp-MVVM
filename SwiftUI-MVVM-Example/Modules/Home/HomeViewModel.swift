//
//  HomeViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

protocol HomeViewModelProtocol: RequestableMediaListProtocol {
    var mediaSections: [String: MediaSectionValue] { get }
    var isPageLoaded: Bool { get }
    
    func increasePage(withSectionKey key: String)
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var mediaSections: [String: MediaSectionValue] = [:]
    @Published var isPageLoaded: Bool = false
    
    init() {
        sectionInit()
    }
}

// MARK: - Api process
extension HomeViewModel {
    private func sectionInit() {
        for (mediaSectionKey, mediaSectionValues) in mediaSectionInitilizer {
            let endpoint: URL = createSectionEndpoint(sectionKey: mediaSectionValues.endpoint, page: 1)
            handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
                DispatchQueue.main.async {
                    self?.mediaSections[mediaSectionKey] = MediaSectionValue(mediaList: mediaList, page: 1, type: mediaSectionValues.type)
                    self?.filtMediaListQuality(mediaSectionKey)
                    self?.isPageLoaded = true
                }
            }
        }
    }
    
    private func createSectionEndpoint(sectionKey key: String, page: Int, pathVariables: [String]? = nil) -> URL {
        NetworkManager.shared.createRequestURL(key, pathVariables: pathVariables, headerParams: [
            "page": page,
            "api_key": AppEnvironments.apiKey
        ])
    }
    
    private func updateSection(_ key: String, endpointRawValue: String, page: Int) {
        let endpoint: URL = createSectionEndpoint(sectionKey: endpointRawValue, page: page)
        handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.mediaSections[key]?.mediaList += mediaList
                self?.filtMediaListQuality(key)
            }
        }
    }
}

// MARK: - Request Properties
extension HomeViewModel {
    private var mediaSectionInitilizer: [String: MediaSectionInitilizerValue] {
        [
            "Popular on TV": MediaSectionInitilizerValue(endpoint: ApiEndpoints.popularOnTV.rawValue, type: .tvShow),
            "Top Rated on TV": MediaSectionInitilizerValue(endpoint: ApiEndpoints.topRatedTV.rawValue, type: .tvShow),
            "Popular Movies": MediaSectionInitilizerValue(endpoint: ApiEndpoints.popularMovies.rawValue, type: .movie),
            "Top Rated Movies": MediaSectionInitilizerValue(endpoint: ApiEndpoints.topRatedMovies.rawValue, type: .movie),
            "Trending Movies": MediaSectionInitilizerValue(endpoint: ApiEndpoints.trendingMovie.rawValue, type: .movie),
            "Trending TV": MediaSectionInitilizerValue(endpoint: ApiEndpoints.trendingTv.rawValue, type: .tvShow)
        ]
    }
}

// MARK: - Interface Properties
extension HomeViewModel {
    func increasePage(withSectionKey key: String) {
        mediaSections[key]?.page += 1
        let page = mediaSections[key]?.page ?? 0
        guard page < 10 else { return }
        let endpointRawValue = mediaSectionInitilizer[key]?.endpoint ?? ""
        updateSection(key, endpointRawValue: endpointRawValue, page: page)
    }
}

// MARK: - Filter Logic
extension HomeViewModel {
    private func filtMediaListQuality(_ key: String) {
        mediaSections[key]?.mediaList = mediaSections[key]?.mediaList.filter { !$0.overview.isEmpty } ?? []
    }
}

struct MediaSectionValue {
    var mediaList: [Media]
    var page: Int
    var type: MediaTypes
}

struct MediaSectionInitilizerValue {
    var endpoint: String
    var type: MediaTypes
}
