//
//  CustomSectionView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import SwiftUI

struct CustomSectionView<Content: View> : View {
    private let content: Content
    private let title: String
    private let titleFont: Font
    
    init(title: String, font: Font? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
        self.titleFont = font ?? .largeTitle
    }
    
    var body: some View {
        VStack(spacing: 5){
            HStack {
                Text(title)
                    .font(titleFont)
                Spacer()
            }.padding(.horizontal)
            content
        }
    }
}
