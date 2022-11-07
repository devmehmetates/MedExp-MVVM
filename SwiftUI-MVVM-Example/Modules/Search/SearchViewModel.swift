//
//  SearchViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 7.11.2022.
//

import Foundation

protocol SearchViewModelProtocol: RequestableMovieListProtocol {
    var searchList: [Movie] { get }
    var searchKey: String { get set }
    func setPage(_ index: Int)
}

class SearchViewModel: SearchViewModelProtocol {
    @Published var searchList: [Movie] = []
    @Published var page: Int = 1 {
        didSet {
            handleSearchMovie()
        }
    }
    @Published var searchKey: String = "" {
        didSet {
            searchList.removeAll()
            if searchKey.isEmpty {
                page = 1
            }
            handleSearchMovie()
        }
    }
    
    func setPage(_ index: Int) {
        if index == searchList.count - 3 {
            page < 10 ? page += 1 : nil
        }
    }
    
    private func handleSearchMovie() {
        let url = NetworkManager.shared.createRequestURL(ApiEndpoints.search.rawValue, page: page, query: searchKey)
        handleMovieListApiRequests(endPoint: url) { [weak self] movieList in
            DispatchQueue.main.async {
                self?.searchList += movieList
            }
        }
    }
}
