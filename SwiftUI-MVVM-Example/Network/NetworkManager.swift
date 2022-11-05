//
//  NetworkManager.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 4.11.2022.
//

import Foundation

struct NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func createRequestURL(_ endPoint: String, page: Int? = nil) -> URL {
        if let page {
            return URL(string: "https://api.themoviedb.org/3\(endPoint)=\(page)&api_key=\(AppEnvironments.apiKey)")!
        }
        
        return URL(string: "https://api.themoviedb.org/3/\(endPoint)&api_key=\(AppEnvironments.apiKey)")!
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
//    func apiRequest<T: Decodable>(endPoint: ApiEndpoints, page: Int? = nil, method: HttpMethods? = .get, completion: @escaping (Result<T, RequestErrors>) -> Void){
//        DispatchQueue.main.async {
//            var request = URLRequest(url: apiURLGenerator(endPoint.rawValue, page: page))
//            request.httpMethod = method?.rawValue
//            request.setValue("899f5edccc021bb929f278c024a08d29", forHTTPHeaderField: "api_key")
//
//            guard let method else { return nil }
//            switch method {
//            case .get:
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    guard let data = data, let decodedData: T = data.decodedModel() else { return completion(.failure(.unknowed)) }
//                    return completion(.success(decodedData))
//                }.resume()
//            case .post:
//                print("hi")
//
//        }
//    }
    
    func createimageUrl(withPath path: String?) -> String {
        "https://www.themoviedb.org/t/p/original\(path ?? "")"
    }
}

enum ApiEndpoints: String {
    case discoverTV = "/discover/tv?sort_by=popularity.desc&page"
    case discoverMovie = "/discover/movie?sort_by=popularity.desc&page"
    case topRatedTV = "/tv/top_rated?page"
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
