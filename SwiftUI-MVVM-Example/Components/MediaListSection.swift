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
    var mediaType: MediaTypes
    var cardOnAppear: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0.responsizeW) {
            Text(sectionTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 5.0.responsizeW)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(zip(mediaList.indices, mediaList)), id: \.1.id) { index, media in
                        NavigationLink {
                            if mediaType == .movie {
                                
                            } else {
                                
                            }
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
}

struct MediaListSection_Previews: PreviewProvider {
    static var previews: some View {
        MediaListSection(mediaList: [], sectionTitle: "On TV", mediaType: .movie) {
            
        }
    }
}
