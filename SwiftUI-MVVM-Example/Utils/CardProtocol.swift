//
//  CardProtocol.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import SwiftUI

protocol CardView { }
extension CardView {
    func cardBackground(overlayLinearGradient: LinearGradient, colorScheme: ColorScheme) -> some View {
        Rectangle()
            .foregroundStyle(overlayLinearGradient)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.3), radius: colorScheme == .dark ? 0 : 8)
    }
}
