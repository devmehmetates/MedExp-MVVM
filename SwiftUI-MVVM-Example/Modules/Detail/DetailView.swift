//
//  DetailView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 10.11.2022.
//

import SwiftUI
import StickyAsyncImageSwiftUI

struct DetailView<Model>: View where Model: DetailViewModelProtocol {
    @ObservedObject var viewModel: Model
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Group {
            if let media = viewModel.mediaDetail {
                ScrollView {
                    StickyAsyncImageSwiftUI(url: URL(string: media.originalBackdropImage), size: 50.0.responsizeW, coordinateSpace: "sticky", isGradientOn: true, linearGradient: overlayLinearGradient)
                    createImageHeaderInformationStack(media: media)
                    VStack(spacing: 3.0.responsizeW) {
                        if !media.overview.isEmpty {
                            CustomSectionView(title: "Overview") {
                                Text(media.overview)
                                    .font(.caption)
                                    .padding(.horizontal)
                            }
                        }
                        if !viewModel.mediaActors.isEmpty {
                            CustomSectionView(title: "Actors") {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.mediaActors) { mediaActor in
                                            ActorCardView(actor: mediaActor)
                                        }
                                    }.padding([.horizontal, .bottom])
                                }
                            }
                        }
                        if !viewModel.mediaVideos.isEmpty {
                            CustomSectionView(title: "Videos") {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.mediaVideos) { mediaVideo in
                                            YoutubeVideoView(mediaVideo.videoLink)
                                        }
                                    }.padding([.horizontal, .bottom])
                                }
                            }
                        }
                        if !viewModel.recommendedMedia.isEmpty {
                            MediaListSection(mediaList: viewModel.recommendedMedia, sectionTitle: "You May Like", titleFont: .title, mediaType: viewModel.mediaType)
                        }
                    }
                }.coordinateSpace(name: "sticky")
                    .ignoresSafeArea(edges: .top)
                    
            } else {
                createLoadingState()
                    .onAppear {
                        viewModel.handleMediaDetail()
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(mediaId: 95403, mediaType: .tvShow))
    }
}

// MARK: - View Components
extension DetailView {
    func createImageHeaderInformationStack(media: Media) -> some View {
        VStack {
            HStack {
                AnimatedAsyncImageView(path: media.posterImage)
                    .frame(width: 40.0.responsizeW, height: 60.0.responsizeW)
                    .transformEffect(CGAffineTransform(1, 0, 0, 1, 0, -10.0.responsizeW))
                VStack(alignment: .leading) {
                    Text(media.title)
                        .lineLimit(4)
                        .font(.system(size: 6.responsizeW, weight: .bold))
                    Text(media.releaseYear)
                        .font(.footnote)
                    Spacer()
                    if let mediaHomePage: URL = URL(string: media.mediaHomePage), let logoPath = media.mediaNetworks.first?.logoImagePath {
                        Button {
                            openURL(mediaHomePage)
                        } label: {
                            LogoImageView(imagePath: logoPath)
                        }
                    }
                }
                Spacer()
            }.padding(.horizontal)
                .frame(height: 40.0.responsizeW)
        }
    }
}

// MARK: - Color Properties
extension DetailView {
    private var overlayLinearGradient: LinearGradient {
        LinearGradient(
            colors: [backgroundColor.opacity(0.5), backgroundColor],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
}
