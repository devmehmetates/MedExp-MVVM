//
//  Actor.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

struct Actor: Codable, Identifiable {
    let id: Int
    private let name: String?
    private let originalName: String?
    private let profilePath: String?
    private let roles: [Role?]?
    private let order: Int?
    
    var actorName: String { originalName ?? name ?? "" }
    var profileImagePath: String { NetworkManager.shared.createPosterimageUrl(withPath: profilePath) }
    var actorRoles: Role? { (roles ?? []).compactMap{ $0 }.first }
    var actorOrder: Int { order ?? 99 }
    
    enum CodingKeys: String, CodingKey {
        case id, name, roles, order
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
