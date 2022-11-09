//
//  SearchMediaCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct SearchMediaCardView: View {
    @Environment(\.colorScheme) var colorScheme
    let destination: AnyView
    let media: Media
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            cardBody
        }.listRowBackground(cardBackground)
    }
}

// MARK: View Component(s)
extension SearchMediaCardView {
    private var mediaInformationStack: some View {
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
    }
    
    private var cardBody: some View {
        HStack {
            AnimatedAsyncImageView(path: media.posterImage)
                .frame(width: 30.0.responsizeW)
                .padding(.trailing, 1.0.responsizeW)
            mediaInformationStack
        }.frame(height: 45.0.responsizeW)
    }
    
    private var cardBackground: some View {
        AnimatedAsyncImageView(path: media.backdropImage, cornerRadius: 0).overlay {
            Rectangle()
                .foregroundColor(backgroundColor)
                .opacity(0.8)
        }
    }
}

// MARK: Color properties
extension SearchMediaCardView {
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
}


