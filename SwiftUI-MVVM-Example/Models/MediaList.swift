//
//  MediaList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

struct MediaList: Codable {
    private let results: [Media]?
    var mediaList: [Media] { results ?? [] }
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
