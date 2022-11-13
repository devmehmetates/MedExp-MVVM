//
//  TabbarRoot.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 6.11.2022.
//

import SwiftUI

struct TabbarRoot: View {
    @State private var currentTab: String = "Home"
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomeView(viewModel: HomeViewModel())
                .tag("Home")
            SearchView(viewModel: SearchViewModel())
                .tag("Search")
        }.overlay(alignment: .bottom) {
            bottomTabbarStack
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

// MARK: View Component(s)
extension TabbarRoot {
    private var bottomTabbarStack: some View {
        HStack {
            TabbarButton(currentTab: $currentTab, title: "Home", icon: "rectangle.portrait")
            TabbarButton(currentTab: $currentTab, title: "Search", icon: "magnifyingglass")
        }
    }
}

struct TabbarRoot_Previews: PreviewProvider {
    static var previews: some View {
        TabbarRoot()
    }
}
