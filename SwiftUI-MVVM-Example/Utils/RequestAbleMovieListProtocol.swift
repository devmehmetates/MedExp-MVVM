//
//  RequestableMediaListProtocol.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 7.11.2022.
//

import Foundation

protocol RequestableMediaListProtocol: ObservableObject { }

extension RequestableMediaListProtocol {
    func handleMediaListApiRequests(endPoint: URL, manager: NetworkManagerProtocol, completion: ((_ mediaList: [Media]) -> Void)? = nil) {
        manager.apiRequest(endpoint: endPoint, param: nil) { response in
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
