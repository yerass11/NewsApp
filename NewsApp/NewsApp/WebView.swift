//
//  WebView.swift
//  NewsApp
//
//  Created by Yerasyl on 28.02.2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url: String
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
}
