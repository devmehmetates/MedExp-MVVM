//
//  RequestAbleMovieListProtocol.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 7.11.2022.
//

import Foundation

protocol RequestableMovieListProtocol: ObservableObject { }

extension RequestableMovieListProtocol {
    func handleMovieListApiRequests(endPoint: URL, completion: ((_ movieList: [Movie]) -> Void)? = nil) {
        NetworkManager.shared.apiRequest(endpoint: endPoint) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MovieList = data.decodedModel() else { return }
                completion?(decodedData.movieList)
            case .failure(_):
                print("err")
            }
        }
    }
}
