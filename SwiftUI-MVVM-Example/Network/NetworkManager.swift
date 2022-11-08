//
//  NetworkManager.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 4.11.2022.
//

import Foundation

struct NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func createRequestURL(_ endPoint: String, page: Int? = nil, query: String? = nil) -> URL {
        let requestPage: String = page != nil ? "=\(page!)&" : ""
        let requestQuery: String = query != nil ? "query=\(safeQuery(query: query!))" : ""
        let apiKey: String = "&api_key=\(AppEnvironments.apiKey)"
        print("https://api.themoviedb.org/3\(endPoint)\(requestPage)\(requestQuery)\(apiKey)")
        
        return URL(string: "https://api.themoviedb.org/3\(endPoint)\(requestPage)\(requestQuery)\(apiKey)")!
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
    case discoverTV = "/discover/tv?sort_by=popularity.desc&page"
    case discoverMovie = "/discover/movie?sort_by=popularity.desc&page"
    case topRatedTV = "/tv/top_rated?page"
    case search = "/search/multi?page"
}

enum RequestErrors: Error {
    case wrongUrl
    case emptyData
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

extension Data {
    func decodedModel<T: Decodable>() -> T? {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: self) else { return nil }
        return decodedData
    }
}
