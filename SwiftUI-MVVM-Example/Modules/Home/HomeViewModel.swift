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
        self.handleMovieListApiRequests(endPoint: NetworkManager.shared.createRequestURL(ApiEndpoints.topRatedTV.rawValue, page: pageCountForTopRatedMovieList)) { [weak self] movieList in
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
        self.handleMovieListApiRequests(endPoint: NetworkManager.shared.createRequestURL(ApiEndpoints.discoverMovie.rawValue, page: pageCountForDiscoverMovieList)) { [weak self] movieList in
            DispatchQueue.main.async {
                self?.discoverMovieList += movieList
            }
        }
    }
    
    private func handleOnTvMovieList() {
        self.handleMovieListApiRequests(endPoint: NetworkManager.shared.createRequestURL(ApiEndpoints.discoverTV.rawValue, page: pageCountForOnTVMovieList)) { [weak self] movieList in
            DispatchQueue.main.async {
                self?.onTVMovieList += movieList
            }
        }
    }
}
