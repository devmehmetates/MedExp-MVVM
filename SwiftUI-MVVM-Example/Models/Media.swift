//
//  Media.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

struct Media: Codable, Identifiable {
    let id: Double
    private let originalName: String?
    private let originalTitle: String?
    private let voteAverage: Double?
    private let backdropPath: String?
    private let posterPath: String?
    private let overView: String?
    private let releaseDate: String?
    private let mediaType: String?
    
    var posterImage: String { NetworkManager.shared.createPosterimageUrl(withPath: posterPath) }
    var backdropImage: String { NetworkManager.shared.createBackdropimageUrl(withPath: backdropPath) }
    var title: String { originalName ?? originalTitle ?? "Unknowed"}
    var point: CGFloat { (voteAverage ?? 0) * 10 }
    var overview: String { overView ?? "Unknowed" }
    var releaseYear: String { releaseDate?.split(separator: "-").first?.description ?? "0" }
    var type: MediaTypes? {
        guard let mediaType else { return nil }
        return mediaType == MediaTypes.movie.rawValue ? .movie : .tvShow
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overView = "overview"
        case releaseDate = "release_date"
        case mediaType = "media_type"
    }
}

enum MediaTypes: String {
    case movie = "movie"
    case tvShow = "tv"
}
