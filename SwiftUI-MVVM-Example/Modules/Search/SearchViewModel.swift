//
//  SearchViewModel.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 7.11.2022.
//

import Foundation

protocol SearchViewModelProtocol: RequestableMediaListProtocol {
    var searchList: [Media] { get }
    var searchKey: String { get set }
    func setPage(_ index: Int)
}

class SearchViewModel: SearchViewModelProtocol {
    @Published var searchList: [Media] = []
    @Published var page: Int = 1 {
        didSet {
            handleSearchMedia()
        }
    }
    @Published var searchKey: String = "" {
        didSet {
            searchList.removeAll()
            if searchKey.isEmpty {
                page = 1
            }
            handleSearchMedia()
        }
    }
    
    func setPage(_ index: Int) {
        if index == searchList.count - 3 {
            page < 10 ? page += 1 : nil
        }
    }
    
    private func handleSearchMedia() {
        let url = NetworkManager.shared.createRequestURL(ApiEndpoints.search.rawValue, headerParams: [
            "page": page,
            "query": searchKey,
            "api_key": AppEnvironments.apiKey
        ])
        handleMediaListApiRequests(endPoint: url) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.searchList += mediaList.filter { $0.title != "Unknowed" }
            }
        }
    }
}
