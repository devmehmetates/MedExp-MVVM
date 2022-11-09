//
//  HeaderCarouselMediaList.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct HeaderCarouselMediaList: View {
    @Environment(\.colorScheme) private var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .black.opacity(0.9) : .white.opacity(0.9) }
    let mediaList: [Media]
    
    var body: some View {
        TabView {
            ForEach(mediaList, id: \.id) { media in
                NavigationLink {
                    
                } label: {
                    AnimatedAsyncImageView(path: media.backdropImage)
                }
            }
        }.tabViewStyle(.page)
            .frame(width: 92.0.responsizeW, height: 40.0.responsizeW)
            .cornerRadius(10)
            .padding(.bottom)
    }
}
