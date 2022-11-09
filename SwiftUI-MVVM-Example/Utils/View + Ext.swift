//
//  View + Ext.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 9.11.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func createLoadingState() -> some View {
        VStack {
            ProgressView()
        }
    }
}
