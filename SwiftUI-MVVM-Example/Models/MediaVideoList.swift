//
//  MediaVideoList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

struct MediaVideoList: Codable, Identifiable {
    let id: Double
    private let results: [MediaVideos?]?
    
    var mediaVideoList: [MediaVideos] { results?.compactMap{ $0 } ?? [] }
}
