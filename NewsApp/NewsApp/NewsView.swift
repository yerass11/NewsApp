//
//  NewsView.swift
//  NewsApp
//
//  Created by Yerasyl on 28.02.2024.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct NewsView: View {
    @State var searchText: String = ""
    @State private var isNavigateToEverything = false
    @ObservedObject var list: GetData
    
    init(searchText: String = "apple") {
        self.list = GetData(search: searchText, isTopHeadline: false)
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                TextField("Search", text: $searchText, onCommit: {
                    // When user presses return/done after typing search text
                    // Update the search query for GetData
                    list.search = searchText
                    isNavigateToEverything = true
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer()
                
                // Use NavigationLink to navigate to Everything view
                NavigationLink(
                    destination: TopHeadlinesNews(newsAbout: searchText, navTitle: searchText + " News", isTop: false),
                    isActive: $isNavigateToEverything
                ) {
                    EmptyView()
                }
                .hidden()
                
            }
        }
    }
}



struct TopHeadlinesNews: View {
    var isTop: Bool
    @State var newsAbout: String = "apple"
    @State var navTitle: String
    @ObservedObject var list: GetData
    
    init (newsAbout: String, navTitle: String, isTop: Bool = true) {
        self.isTop = isTop
        self.list = GetData(search: newsAbout, isTopHeadline: isTop)
        self.navTitle = navTitle
    }
    
    var body: some View {
        NavigationView {
            List(list.datas) { i in
                
                NavigationLink(destination: WebView(url: i.url)
                    .navigationBarTitle("", displayMode: .inline)) {
                        
                    VStack(spacing: 15) {
                        
                        if i.image != "" {
                            WebImage(url: URL(string: i.image)!, options: .highPriority, context: nil)
                                .resizable()
                                .frame(height: 195)
                                .cornerRadius(20)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                        
                            Text(i.title)
                                .fontWeight(.black)
                            Text(i.desc)
                                .lineLimit(5)
                        }
                        
                    }.padding(.vertical, 16)
                }
            }.navigationTitle(navTitle)
        }
    }
}
