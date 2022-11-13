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
    // Discover Tab
    case popularOnTV = "/tv/popular"
    case popularMovies = "/movie/popular"
    case topRatedTV = "/tv/top_rated"
    case topRatedMovies = "/movie/top_rated"
    // Trending Tab
    case trendingMovie = "/trending/movie/week"
    case trendingTv = "/trending/tv/week"
    // Search Tab
    case search = "/search/multi"
    // DetailPage
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
    
    func createOriginalImageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/original\(path ?? "")"
    }
    
    func createLogoimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/w92\(path ?? "")"
    }
}

// MARK: - Request URL Function(s)
extension NetworkManager {
    func createRequestURL(_ endpoint: String, pathVariables: [String]? = nil, headerParams: [String: Any]? = nil) -> URL {
        var requestParams: String = ""
        requestParams += ("?api_key=\(AppEnvironments.apiKey)")
        for (key, value) in (headerParams ?? [:]) {
            if key == "query" {
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
