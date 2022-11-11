//
//  YoutubeVideoView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: View {
    private let key: String
    
    init(_ videoKey: String) {
        self.key = videoKey
    }
    
    var body: some View {
        YoutubeVideoViewBranch(key)
            .frame(width: 80.0.responsizeW, height: 50.0.responsizeW)
            .background(.ultraThickMaterial)
            .cornerRadius(5)
    }
}

struct YoutubeVideoViewBranch: UIViewRepresentable {
    private let key: String
    
    init(_ videoKey: String) {
        self.key = videoKey
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let path = "https://www.youtube.com/embed/\(key)"
        guard let url = URL(string: path) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}

struct YoutubeVideoCiew_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoView("pycigmeHVmM")
    }
}
