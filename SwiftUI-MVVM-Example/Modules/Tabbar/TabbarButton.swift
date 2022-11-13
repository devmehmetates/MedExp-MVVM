//
//  TabbarButton.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct TabbarButton: View {
    @Binding var currentTab: String
    private var isSelected: Bool { currentTab == title }
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: buttonAction) {
            buttonLabel
        }
    }
}

// MARK: - View Component(s)
extension TabbarButton {
    private var buttonLabel: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
        }.frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? .accentColor : .secondary)
    }
    
    private func buttonAction() {
        withAnimation {
            currentTab = title
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
