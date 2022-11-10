//
//  HomeViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

protocol HomeViewModelProtocol: RequestableMediaListProtocol {
    var isPageLoaded: Bool { get }
    var onTVMediaList: [Media] { get }
    var topRatedMediaList: [Media] { get }
    var onTheAirMediaList: [Media] { get }
    var discoverMediaList: [Media] { get }
    var headerCarouselMediaList: [Media] { get }
    
    func setpageCountForOnTVMediaList()
    func setpageCountForTopRatedMediaList()
    func setpageCountForOnTheAirMediaList()
    func setpageCountForDiscoverMediaList()
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var onTVMediaList: [Media] = []
    @Published var topRatedMediaList: [Media] = []
    @Published var onTheAirMediaList: [Media] = []
    @Published var discoverMediaList: [Media] = []
    @Published var headerCarouselMediaList: [Media] = []
    @Published var isPageLoaded: Bool = false
    func setpageCountForOnTVMediaList() { pageCountForOnTVMediaList < 10 ? pageCountForOnTVMediaList += 1 : nil }
    func setpageCountForTopRatedMediaList() { pageCountForTopRatedMediaList < 10 ? pageCountForTopRatedMediaList += 1 : nil }
    func setpageCountForOnTheAirMediaList() { pageCountForOnTheAirMediaList < 10 ? pageCountForOnTheAirMediaList += 1 : nil }
    func setpageCountForDiscoverMediaList() { pageCountForDiscoverMediaList < 10 ? pageCountForDiscoverMediaList += 1 : nil }
    
    init() {
        handleMediaLists()
    }
    
    private var pageCountForOnTVMediaList: Int = 1 {
        didSet {
            handleOnTvMediaList()
        }
    }
    private var pageCountForTopRatedMediaList: Int = 1 {
        didSet {
            handleTopRatedMediaList()
        }
    }
    private var pageCountForOnTheAirMediaList: Int = 1 {
        didSet {
            handleOnTheAirMediaList()
        }
    }
    private var pageCountForDiscoverMediaList: Int = 1 {
        didSet {
            handleDiscoverMediaList()
        }
    }
    
    // MARK: - Initilize method(s)
    private func handleMediaLists() {
        handleOnTvMediaList()
        handleTopRatedMediaList()
        handleOnTheAirMediaList()
        handleDiscoverMediaList()
    }
    
    // MARK: - Api process
    private func handleTopRatedMediaList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.topRatedTV.rawValue, headerParams: [
            "page": pageCountForTopRatedMediaList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
            DispatchQueue.main.async {
                guard let self else { return }
                if self.pageCountForTopRatedMediaList == 1 {
                    self.headerCarouselMediaList = mediaList
                    self.isPageLoaded.toggle()
                    self.setpageCountForTopRatedMediaList()
                } else {
                    self.topRatedMediaList += mediaList
                }
            }
        }
    }
    
    private func handleOnTheAirMediaList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.onTheAir.rawValue, headerParams: [
            "page": pageCountForOnTheAirMediaList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.onTheAirMediaList += mediaList
            }
        }
    }
    
    private func handleDiscoverMediaList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.discoverMovie.rawValue, headerParams: [
            "sort_by": "popularity.desc",
            "page": pageCountForDiscoverMediaList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.discoverMediaList += mediaList
            }
        }
    }
    
    private func handleOnTvMediaList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.discoverTV.rawValue, headerParams: [
            "sort_by": "popularity.desc",
            "page": pageCountForOnTVMediaList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMediaListApiRequests(endPoint: endpoint) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.onTVMediaList += mediaList
            }
        }
    }
}
