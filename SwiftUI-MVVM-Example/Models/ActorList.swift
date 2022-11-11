//
//  ActorList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

struct ActorList: Codable, Identifiable {
    let id: Int
    private let cast: [Actor?]?
    
    var actorList: [Actor] { (cast ?? []).compactMap{ $0 }.filter{ $0.actorOrder <= 10 }.sorted { $0.actorOrder < $1.actorOrder } }
}
