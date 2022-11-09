//
//  SearchMediaCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct SearchMediaCardView: View {
    @Environment(\.colorScheme) var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
    
    let destination: AnyView
    let media: Media
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                AnimatedAsyncImageView(path: media.posterImage)
                    .frame(width: 30.0.responsizeW)
                    .padding(.trailing, 1.0.responsizeW)
                VStack(alignment: .leading) {
                    Text(media.title)
                        .font(.title3)
                        .lineLimit(2)
                    Text("(\(media.releaseYear))")
                        Spacer()
                    Text(media.overview)
                        .font(.caption)
                        .lineLimit(6)
                    Spacer()
                }
                
            }.frame(height: 45.0.responsizeW)
            
        }.listRowBackground (AnimatedAsyncImageView(path: media.backdropImage, cornerRadius: 0)
            .overlay {
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .opacity(0.8)
            })
    }
}
