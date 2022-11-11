//
//  Role.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

struct Role: Codable {
    private let character: String?
    
    var roleName: String { character ?? "" }
}
