//
//  AnimatedAsyncImageView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 3.11.2022.
//

import SwiftUI

struct AnimatedAsyncImageView: View {
    private var url: URL? {
        URL(string: path)
    }
    
    let path: String
    var cornerRadius: Double?
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .clipped()
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(.ultraThickMaterial)
                }
            }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                .cornerRadius(cornerRadius ?? 10.0)
        }
    }
}

struct AnimatedAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedAsyncImageView(path: AppConstants.shared.exampleImagePath)
    }
}
