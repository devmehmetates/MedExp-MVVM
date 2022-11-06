//
//  MovieList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

struct MovieList: Codable {
    private let results: [Movie]?
    var movieList: [Movie] { results ?? [] }
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
