//
//  NetworkManager.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 4.11.2022.
//

import Foundation

struct NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func createRequestURL(_ endpoint: String, headerParams: [String: Any]? = nil) -> URL {
        var requestParams: String = ""
        for (key, value) in (headerParams ?? [:]) {
            if key == headerParams?.keys.first ?? "" {
                requestParams += ("?\(key)=\(value)")
            } else if key == "query" {
                requestParams += ("&\(key)=\(safeQuery(query: value as? String ?? ""))")
            } else {
                requestParams += ("&\(key)=\(value)")
            }
        }
        return URL(string: "https://api.themoviedb.org/3\(endpoint)\(requestParams)")!
    }
    
    func apiRequest(endpoint: URL, param: Data? = nil, completion: @escaping (Result<Data, RequestErrors>) -> Void) {
        var request = URLRequest(url: endpoint)
        let method = param != nil ? HttpMethods.post.rawValue : HttpMethods.get.rawValue
        request.httpMethod = method
        request.httpBody = param
        request.setValue(AppEnvironments.apiKey, forHTTPHeaderField: "api_key")
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data else { return completion(.failure(.emptyData)) }
            return completion(.success(data))
        }.resume()
    }
    
    func createPosterimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/w342\(path ?? "")"
    }
    
    func createBackdropimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/w780\(path ?? "")"
    }
    
    private func safeQuery(query: String) -> String {
        query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

enum ApiEndpoints: String {
    case discoverTV = "/discover/tv"
    case discoverMovie = "/discover/movie"
    case topRatedTV = "/tv/top_rated"
    case search = "/search/multi"
}

enum RequestErrors: Error {
    case wrongUrl
    case emptyData
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}
