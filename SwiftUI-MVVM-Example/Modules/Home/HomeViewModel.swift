//
//  HomeViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

protocol HomeViewModelProtocol: RequestableMovieListProtocol {
    var isPageLoaded: Bool { get }
    var onTVMovieList: [Movie] { get }
    var topRatedMovieList: [Movie] { get }
    var discoverMovieList: [Movie] { get }
    var topRatedMovieBackdropList: [Movie] { get }
    
    func setpageCountForOnTVMovieList()
    func setpageCountForTopRatedMovieList()
    func setpageCountForDiscoverMovieList()
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var onTVMovieList: [Movie] = []
    @Published var topRatedMovieList: [Movie] = []
    @Published var discoverMovieList: [Movie] = []
    @Published var topRatedMovieBackdropList: [Movie] = []
    @Published var isPageLoaded: Bool = false
    func setpageCountForOnTVMovieList() { pageCountForOnTVMovieList < 10 ? pageCountForOnTVMovieList += 1 : nil }
    func setpageCountForTopRatedMovieList() { pageCountForTopRatedMovieList < 10 ? pageCountForTopRatedMovieList += 1 : nil }
    func setpageCountForDiscoverMovieList() { pageCountForDiscoverMovieList < 10 ? pageCountForDiscoverMovieList += 1 : nil }
    
    init() {
        handleMovieLists()
    }
    
    private var pageCountForOnTVMovieList: Int = 1 {
        didSet {
            handleOnTvMovieList()
        }
    }
    private var pageCountForTopRatedMovieList: Int = 1 {
        didSet {
            handletopRatedMovieList()
        }
    }
    private var pageCountForDiscoverMovieList: Int = 1 {
        didSet {
            handleDiscoverMovieList()
        }
    }
    
    private func handleMovieLists() {
        handleOnTvMovieList()
        handletopRatedMovieList()
        handleDiscoverMovieList()
       
    }
    
    private func handletopRatedMovieList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.topRatedTV.rawValue, headerParams: [
            "page": pageCountForTopRatedMovieList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMovieListApiRequests(endPoint: endpoint) { [weak self] movieList in
            DispatchQueue.main.async {
                guard let self else { return }
                if self.pageCountForTopRatedMovieList == 1 {
                    self.topRatedMovieBackdropList = movieList
                    self.isPageLoaded.toggle()
                    self.setpageCountForTopRatedMovieList()
                } else {
                    self.topRatedMovieList += movieList
                }
            }
        }
    }
    
    private func handleDiscoverMovieList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.discoverMovie.rawValue, headerParams: [
            "sort_by": "popularity.desc",
            "page": pageCountForDiscoverMovieList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMovieListApiRequests(endPoint: endpoint) { [weak self] movieList in
            DispatchQueue.main.async {
                self?.discoverMovieList += movieList
            }
        }
    }
    
    private func handleOnTvMovieList() {
        let endpoint = NetworkManager.shared.createRequestURL(ApiEndpoints.discoverTV.rawValue, headerParams: [
            "sort_by": "popularity.desc",
            "page": pageCountForOnTVMovieList,
            "api_key": AppEnvironments.apiKey
        ])
        self.handleMovieListApiRequests(endPoint: endpoint) { [weak self] movieList in
            DispatchQueue.main.async {
                self?.onTVMovieList += movieList
            }
        }
    }
}
