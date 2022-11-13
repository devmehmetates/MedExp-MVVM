//
//  LazyNavigate.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 13.11.2022.
//

import SwiftUI

struct LazyNavigate<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
