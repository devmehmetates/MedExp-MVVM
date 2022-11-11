//
//  MediaListSection.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct MediaListSection: View {
    let mediaList: [Media]
    let sectionTitle: String
    let titleFont: Font
    let mediaType: MediaTypes
    var cardOnAppear: (() -> Void)? = nil
    
    init(mediaList: [Media], sectionTitle: String, titleFont: Font? = nil, mediaType: MediaTypes, cardOnAppear: ( () -> Void)? = nil) {
        self.mediaList = mediaList
        self.sectionTitle = sectionTitle
        self.titleFont = titleFont ?? .title2
        self.mediaType = mediaType
        self.cardOnAppear = cardOnAppear
    }
    
    var body: some View {
        CustomSectionView(title: sectionTitle, font: titleFont) {
            mediaHorizontalScrollList
        }
    }
}

// MARK: - View Component(s)
extension MediaListSection {
    private var mediaHorizontalScrollList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Array(zip(mediaList.indices, mediaList)), id: \.1.id) { index, media in
                    NavigationLink {
                        DetailView(viewModel: DetailViewModel(mediaId: Int(media.id), mediaType: mediaType))
                    } label: {
                        MediaCardView(media: media)
                            .onAppear {
                                if index == mediaList.count - 3 {
                                    cardOnAppear?()
                                }
                            }
                    }
                }
            }.padding([.horizontal, .bottom])
        }
    }
}

struct MediaListSection_Previews: PreviewProvider {
    static var previews: some View {
        MediaListSection(mediaList: [], sectionTitle: "On Tv", mediaType: .movie) {
            
        }
    }
}
