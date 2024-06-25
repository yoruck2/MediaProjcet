//
//  TrendingViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

import Alamofire
import SnapKit

class TrendingViewController: UIViewController {
    
//    var trendingData: TrendingDTO = TrendingDTO
    
    lazy var trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()   // tableView.rowHeight 역할
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2)
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = cellSpacing
//        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        configureUI()
        
//        trendingCollectionView.delegate = self
//        trendingCollectionView.dataSource = self
        trendingCollectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.id)
    }
    
    func configureHierachy() {
        view.addSubview(trendingCollectionView)
    }
    func configureLayout() {
        trendingCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI() {
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        let menu = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet"),
            style: .plain,
            target: self,
            action: #selector(menuItemTapped))
        
        let search = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchItemTapped))
        
        navigationItem.title = "지금 뜨는 컨텐츠"
        navigationItem.leftBarButtonItem = menu
        navigationItem.rightBarButtonItem = search
    }
    
    @objc
    func menuItemTapped() {
    }
    
    @objc
    func searchItemTapped() {
        self.present(SearchMovieViewController(), animated: true)
    }
}

//extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        trendingData?.results.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.id, for: indexPath) as? TrendingCollectionViewCell
//        else {
//            return UICollectionViewCell()
//        }
//
//        return cell
//    }
//}
