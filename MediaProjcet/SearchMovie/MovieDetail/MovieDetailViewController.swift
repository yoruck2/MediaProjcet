//
//  MovieDetailViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import UIKit

import SnapKit
import Then

class MovieDetailViewController: UIViewController {
    
    let network = NetworkManager.shared
    var page = 1
    
    var searchedMovieData: SearchResultDTO?
    var similarMovieData: SimilarDTO?
    var recommendationMovieData: RecommendationDTO?
    
    let movietitleLabel = UILabel().then {
        $0.font = Font.bold20
    }
    let similarMovieLabel = UILabel().then {
        $0.text = "비슷한 영화"
        $0.font = Font.bold15
    }
    let recommendMovieLabel = UILabel().then {
        $0.text = "추천 영화"
        $0.font = Font.bold15
    }
    
    lazy var similarMovieCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: collectionViewLayout())
    lazy var recommendMovieCollectionViewController = UICollectionView(frame: .zero,
                                                                       collectionViewLayout: collectionViewLayout())
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        //        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        let width = UIScreen.main.bounds.width * 0.3
        layout.itemSize = CGSize(width: width, height: width * 1.7)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        //        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func loadView() {
        movietitleLabel.text = searchedMovieData?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureUI()
        
        network.requestSimilarMovie(movieID: Int(searchedMovieData?.id ?? 0), page: page) { data in
            self.similarMovieData = data
        }
        network.requestRecommandMovie(movieID: Int(searchedMovieData?.id ?? 0), page: page) { data in
            self.recommendationMovieData = data
        }
    }
    
    func configureHierachy() {
        view.addSubviews(movietitleLabel,
                         similarMovieLabel,
                         similarMovieCollectionView,
                         recommendMovieLabel,
                         recommendMovieCollectionViewController)
    }
    
    func configureLayout() {
        movietitleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        similarMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(movietitleLabel.snp.bottom).offset(40)
        }
        similarMovieCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(similarMovieLabel.snp.bottom).offset(15)
        }
        recommendMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(similarMovieCollectionView.snp.bottom).offset(30)
        }
        recommendMovieCollectionViewController.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(recommendMovieLabel.snp.bottom).offset(15)
        }
    }
    
    func configureUI() {
        similarMovieCollectionView.delegate = self
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.id)
        
        recommendMovieCollectionViewController.delegate = self
        recommendMovieCollectionViewController.dataSource = self
        recommendMovieCollectionViewController.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.id)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard
            let similarMovieList = similarMovieData?.results,
            let RecommendationMovieList = recommendationMovieData?.results
        else {
            return 1
        }
        
        if collectionView == similarMovieCollectionView {
            return similarMovieList.count
        } else if collectionView == recommendMovieCollectionViewController {
            return RecommendationMovieList.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.id, for: indexPath)
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPaths in indexPaths {
            guard let list = searchResultData?.items, let selectedSortMode else {
                return
            }
            if list.count - 2 <= indexPaths.item {
                page += 1
                if collectionView == similarMovieCollectionView {
                    network.requestSimilarMovie(movieID: Int(searchedMovieData?.id ?? 0), page: page) { data in
                        self.similarMovieData?.results.append(contentsOf: data.results)
                        self.similarMovieCollectionView.reloadData()
                    }
                } else {
                    network.requestRecommandMovie(movieID: Int(recommendationMovieData?.id ?? 0), page: page) { data in
                        self.similarMovieData?.results.append(contentsOf: data.results)
                        self.similarMovieCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}
