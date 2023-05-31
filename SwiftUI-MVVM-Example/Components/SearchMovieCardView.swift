//
//  SearchMediaCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

struct SearchMediaCardView: View {
    @Environment(\.colorScheme) var colorScheme
    let media: Media
    @State private var isInformationOn: Bool = false
    @State private var isActive = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            cardBody
                .offset(y: isInformationOn ? -55.0.responsizeW : 0)
            cardInformation
                .offset(y: isInformationOn ? 0 : 50.0.responsizeW)
                .opacity(isInformationOn ? 1 : 0)
        }.onTapGesture {
            isActive.toggle()
        }.onLongPressGesture {
            withAnimation(.spring()) {
                isInformationOn.toggle()
            }
        }.onDisappear{
            isInformationOn = false
        }.clipped()
            .background(
                NavigationLink(destination: LazyNavigate(DetailView(viewModel: DetailViewModel(mediaId: Int(media.id), mediaType: media.type ?? .tvShow))),isActive: $isActive) {
                            EmptyView()
                        })
    }
}

// MARK: View Component(s)
extension SearchMediaCardView {
    private var mediaInformationStack: some View {
        VStack(alignment: .leading) {
            Text(media.title)
                .font(.title3)
                .fontWeight(.bold)
                .lineLimit(2)
            Text("(\(media.releaseYear))")
                Spacer()
            Text(media.overview)
                .font(.caption)
                .lineLimit(6)
            Spacer()
        }.padding()
            .frame(width: 45.0.responsizeW, height: 50.0.responsizeW)
            .background(.quaternary)
    }
    
    private var cardBody: some View {
        ZStack(alignment: .bottomTrailing) {
            AnimatedAsyncImageView(path: media.posterImage)
                .aspectRatio(0.65, contentMode: .fill)
            LinearGradient(colors: [.clear, .clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
            HStack(spacing: 5) {
                Text("Press Long")
                Image(systemName: "hand.tap.fill")
            }.font(.caption2)
                .padding()
                .foregroundColor(.white)
        }.cornerRadius(10)
    }
    
    private var cardInformation: some View {
        mediaInformationStack
            .cornerRadius(10)
    }
}

// MARK: Color properties
extension SearchMediaCardView {
    private var backgroundColor: Color { colorScheme == .dark ? .black : .white }
}

struct SearchMediaCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchViewModel()
        SearchView(viewModel: viewModel)
            .onAppear {
                viewModel.searchKey = "Titanic"
            }
    }
}
