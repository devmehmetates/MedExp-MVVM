//
//  LogoImageView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import SwiftUI

struct LogoImageView: View {
    @Environment(\.colorScheme) var colorScheme
    private var backgroundColor: Color { colorScheme == .dark ? .white : .gray.opacity(0.1) }
    let imagePath: String
    
    var body: some View {
        HStack {
            if !imagePath.isEmpty {
                AnimatedAsyncImageView(path: imagePath, cornerRadius: 0, scaleType: .toFit)
                    .frame(width: 10.0.responsizeW, height: 10.0.responsizeW)
            } else {
                VStack {
                    Image(systemName: "globe")
                        .resizable()
                        .foregroundColor(.primary)
                        .frame(width: 5.0.responsizeW, height: 5.0.responsizeW)
                }.frame(width: 10.0.responsizeW, height: 10.0.responsizeW)
            }
        }.padding(1.0.responsizeW)
            .background(backgroundColor)
            .cornerRadius(5)
    }
}
