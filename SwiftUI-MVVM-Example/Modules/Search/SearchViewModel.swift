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
            searchKeyDidSet()
        }
    }
    
    private var manager: NetworkManagerProtocol!
    
    init(manager: NetworkManagerProtocol? = nil) {
        self.manager = manager ?? NetworkManager()
    }
}

// MARK: - Interface Setup
extension SearchViewModel {
    func setPage(_ index: Int) {
        if index == searchList.count - 3 {
            page < 10 ? page += 1 : nil
        }
        
        #if DEBUG
        if index == -1 {
            page += 1
        }
        #endif
    }
}

// MARK: - Logic(s)
extension SearchViewModel {
    private func searchKeyDidSet() {
        searchList.removeAll()
        if searchKey.isEmpty {
            page = 1
        }
        handleSearchMedia()
    }
}

// MARK: - Api process
extension SearchViewModel {
    private func handleSearchMedia() {
        let url = manager.createRequestURL(ApiEndpoints.search.rawValue, pathVariables: nil, headerParams: [
            "page": page,
            "query": searchKey,
        ])
        handleMediaListApiRequests(endPoint: url, manager: manager) { [weak self] mediaList in
            DispatchQueue.main.async {
                self?.searchList += mediaList.filter { $0.title != "Unknowed" }
            }
        }
    }
}
