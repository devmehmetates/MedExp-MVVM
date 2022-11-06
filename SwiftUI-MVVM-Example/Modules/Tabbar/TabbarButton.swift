//
//  TabbarButton.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct TabbarButton: View {
    @Binding var currentTab: String
    let title: String
    let icon: String
    private var isSelected: Bool { currentTab == title }
    
    var body: some View {
        Button {
            withAnimation {
                currentTab = title
            }
        } label: {
            VStack {
                Image(systemName: icon)
                Text(title)
            }.frame(maxWidth: .infinity)
                .foregroundColor(isSelected ? .accentColor : .secondary)
        }
    }
}

struct TabbarButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabbarButton(currentTab: .constant("Home"), title: "Home", icon: "rectangle.portrait")
            TabbarButton(currentTab: .constant("Home"), title: "Search", icon: "magnifyingglass")
        }
    }
}
