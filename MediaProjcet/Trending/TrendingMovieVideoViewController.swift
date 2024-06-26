//
//  TrendingMovieVideoViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 7/2/24.
//

import UIKit

import SnapKit
import Then
import WebKit

final class TrendingMovieVideoViewController: BaseViewController {
    
    let network = TMDBAPI.shared
    var videoData: [Video.Result] = [] {
        didSet {
            configureWebView()
        }
    }
    var movieID: Int = 0
    private let webView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.request(api: .movieVideo(movieId: movieID,
                                         language: .korean),
                        model: Video.self) {data,_ in
            guard let data = data?.results else {
                return
            }
            self.videoData = data
        }
    }
    override func configureHierarchy() {
        view.addSubviews(webView)
    }
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureWebView() {
        let randomVideoRange = Int.random(in: 0...videoData.count - 1)
        let url = URL.make(with: "https://www.youtube.com/watch?v=\(videoData[randomVideoRange].key)")
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
