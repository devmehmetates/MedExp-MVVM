//
//  NetworkManager.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 4.11.2022.
//

import Foundation

struct NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func apiRequest(endpoint: URL, param: Data? = nil, completion: @escaping (Result<Data, RequestErrors>) -> Void) {
        var request = URLRequest(url: endpoint)
        let method = param != nil ? HttpMethods.post.rawValue : HttpMethods.get.rawValue
        request.httpMethod = method
        request.httpBody = param
        
        print("URL LOG:", endpoint.description)
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data else { return completion(.failure(.emptyData)) }
            return completion(.success(data))
        }.resume()
    }
}

// MARK: - Endpoint(s)
enum ApiEndpoints: String {
    case discoverTV = "/discover/tv"
    case discoverMovie = "/discover/movie"
    case topRatedTV = "/tv/top_rated"
    case onTheAir = "/tv/on_the_air"
    case search = "/search/multi"
    case tvShowDetail = "/tv"
    case movieShowDetail = "/movie"
}

// MARK: - Error(s)
enum RequestErrors: Error {
    case wrongUrl
    case emptyData
}

// MARK: - HttpMethod(s)
enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - Image function(s)
extension NetworkManager {
    func createPosterimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/w342\(path ?? "")"
    }
    
    func createBackdropimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/w780\(path ?? "")"
    }
}

// MARK: - Request URL Function(s)
extension NetworkManager {
    func createRequestURL(_ endpoint: String, pathVariables: [Int]? = nil, headerParams: [String: Any]? = nil) -> URL {
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
        
        var pathVariable: String = ""
        for variable in (pathVariables ?? []) {
            pathVariable += "/\(variable)"
        }
        
        guard let url = URL(string: "https://api.themoviedb.org/3\(endpoint)\(pathVariable)\(requestParams)") else { return URL(string: AppConstants.shared.exampleImagePath)! }
        return url
    }
    
    private func safeQuery(query: String) -> String {
        query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
