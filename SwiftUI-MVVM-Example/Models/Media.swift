//
//  Media.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import Foundation

struct Media: Codable, Identifiable {
    let id: Double
    private let adult: Bool?
    private let backdropPath: String?
    private let firstAirDate: String?
    private let genres: [Genres?]?
    private let homepage: String?
    private let name: String?
    private let networks: [Networks?]?
    private let productionCompanies: [Networks?]?
    private let numberOfEpisodes: Int?
    private let numberOfSeasons: Int?
    private let originalName: String?
    private let originalTitle: String?
    private let overView: String?
    private let posterPath: String?
    private let voteAverage: Double?
    private let releaseDate: String?
    private let mediaType: String?
    
    init() {
        self.id = 0
        self.adult = nil
        self.backdropPath = nil
        self.firstAirDate = nil
        self.genres = nil
        self.homepage = nil
        self.name = nil
        self.networks = nil
        self.productionCompanies = nil
        self.numberOfEpisodes = nil
        self.numberOfSeasons = nil
        self.originalName = nil
        self.originalTitle = nil
        self.overView = nil
        self.posterPath = nil
        self.voteAverage = nil
        self.releaseDate = nil
        self.mediaType = nil
    }
    
    var isAdult: Bool { adult ?? false }
    var backdropImage: String { NetworkManager.shared.createBackdropimageUrl(withPath: backdropPath) }
    var originalBackdropImage: String { NetworkManager.shared.createOriginalImageUrl(withPath: backdropPath) }
    var mediaGenres: [Genres] { (genres ?? []).compactMap { $0 } }
    var mediaHomePage: String { homepage ?? "" }
    var title: String { name ?? originalName ?? originalTitle ?? "Unknowed" }
    var mediaNetworks: [Networks] { (networks ?? productionCompanies ?? []).compactMap { $0 } }
    var episodesCount: Int { numberOfEpisodes ?? 0 }
    var sessionCount: Int { numberOfSeasons ?? 0 }
    var overview: String { overView ?? "Unknowed" }
    var posterImage: String { NetworkManager.shared.createPosterimageUrl(withPath: posterPath) }
    var point: CGFloat { (voteAverage ?? 0) * 10 }
    var releaseYear: String { releaseDate?.split(separator: "-").first?.description ?? firstAirDate?.split(separator: "-").first?.description ?? "Unknowed" }
    var type: MediaTypes? {
        guard let mediaType else { return nil }
        return mediaType == MediaTypes.movie.rawValue ? .movie : .tvShow
    }
    
    enum CodingKeys: String, CodingKey {
        case id, adult, genres, homepage, name, networks
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case productionCompanies = "production_companies"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overView = "overview"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case mediaType = "media_type"
    }
}

enum MediaTypes: String {
    case movie = "movie"
    case tvShow = "tv"
}
