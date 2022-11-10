//
//  Genres.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 10.11.2022.
//

struct Genres: Codable, Identifiable {
    let id: Int
    private let name: String?
    
    var genreName: String { name ?? "" }
}
