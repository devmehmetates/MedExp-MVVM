//
//  Data + Ext.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 8.11.2022.
//

import Foundation

extension Data {
    func decodedModel<T: Decodable>() -> T? {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: self) else { return nil }
        return decodedData
    }
}
