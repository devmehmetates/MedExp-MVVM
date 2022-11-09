//
//  RequestableMediaListProtocol.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 7.11.2022.
//

import Foundation

protocol RequestableMediaListProtocol: ObservableObject { }

extension RequestableMediaListProtocol {
    func handleMediaListApiRequests(endPoint: URL, completion: ((_ mediaList: [Media]) -> Void)? = nil) {
        NetworkManager.shared.apiRequest(endpoint: endPoint) { response in
            switch response {
            case .success(let data):
                guard let decodedData: MediaList = data.decodedModel() else { return }
                completion?(decodedData.mediaList)
            case .failure(_):
                print("err")
            }
        }
    }
}
