//
//  Networks.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 10.11.2022.
//

struct Networks: Codable, Identifiable {
    let id: Int
    private let name: String?
    private let logoPath: String?
    
    var networkName: String { name ?? "" }
    var logoImagePath: String { NetworkManager.shared.createPosterimageUrl(withPath: logoPath) }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
    }
}
