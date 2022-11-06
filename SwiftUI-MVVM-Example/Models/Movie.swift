//
//  Movie.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Double
    private let originalName: String?
    private let originalTitle: String?
    private let voteAverage: Double?
    private let backdropPath: String?
    private let posterPath: String?
    
    var posterImage: String { NetworkManager.shared.createimageUrl(withPath: posterPath) }
    var backdropImage: String { NetworkManager.shared.createimageUrl(withPath: backdropPath) }
    var title: String { originalName ?? originalTitle ?? "Unknowed"}
    var point: CGFloat { (voteAverage ?? 0) * 10 }
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
