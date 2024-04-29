//
//  ContentView.swift
//  NewsApp
//
//  Created by Yerasyl on 27.02.2024.
//

import SwiftUI
import SwiftyJSON

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            TopHeadlinesNews(newsAbout: "apple", navTitle: "Apple News")
                .tabItem {
                    if selectedTab == 0 {
                        Label("Apple News", systemImage: "applelogo")
                    } else {
                        Label("Apple News", systemImage: "applelogo")
                    }
                }.tag(0)
            
            NavigationView {
                
                NewsView(searchText: "apple")
                .navigationTitle("Search")
            }.tabItem {
                if selectedTab == 1 {
                    Label("Search", systemImage: "magnifyingglass")
                } else {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }.tag(1)
        }
    }
}




#Preview {
    ContentView()
}
