//
//  MediaVideos.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

struct MediaVideos: Codable, Identifiable {
    let id: String
    private let key: String?
    
    var videoLink: String { key ?? "" }
}
