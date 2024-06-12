//
//  ViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import UIKit

import SnapKit
import Kingfisher

class SearchMovieViewController: UIViewController {
    
    var searchedData: SearchedMovieDTO? {
        didSet {
            guard let data = searchedData?.results, data.isEmpty == false else {
                searchFailedLabel.isHidden = false
                return
            }
            movieList = data
        }
    }
    
    lazy var movieList: [ResultDTO] = []
    
    var page = 1
    
    let movieSearchBar = {
        let view = UISearchBar()
        view.placeholder = "영화 제목을 검색해보세요"
        
        return view
    }()
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()   // tableView.rowHeight 역할
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    lazy var searchFailedLabel = {
        let view = UILabel()
        view.text = "검색 결과가 없습니다"
        view.textColor = .white
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureUI()
        setUpCollectionView()
        setUpSearchBar()
    }
    
    func configureHierachy() {
        view.addSubview(movieSearchBar)
        view.addSubview(movieCollectionView)
        view.addSubview(movieSearchBar)
        view.addSubview(searchFailedLabel)
    }
    
    func configureLayout() {
        movieSearchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(movieSearchBar.snp.bottom).offset(5)
        }
        
        searchFailedLabel.snp.makeConstraints {
            $0.top.equalTo(movieSearchBar.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
//        navigationController?.title = "영화 검색"
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "영화 검색"
//                view.backgroundColor = .black
    }
    func setUpCollectionView() {
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.prefetchDataSource = self
        movieCollectionView.register(SerachMovieCollectionViewCell.self,
                                     forCellWithReuseIdentifier: SerachMovieCollectionViewCell.id)
        
        movieCollectionView.backgroundColor = .clear
    }
    func setUpSearchBar() {
        movieSearchBar.delegate = self
    }
    
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SerachMovieCollectionViewCell.id, for: indexPath) as? SerachMovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        if movieList.isEmpty {
            return cell
        }
        
        cell.cellData = movieList[indexPath.row]
        cell.setUpData()
        return cell
    }
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPaths in indexPaths {
            if movieList.count - 2 == indexPaths.item {
                page += 1
                Network.sendGetRequest(page: page, with: movieSearchBar.text ?? "") { data in
                    self.movieList.append(contentsOf: data.results)
                    self.movieCollectionView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        movieList.removeAll()
        
        guard let text = searchBar.text else {
            return
        }
        Network.sendGetRequest(page: page, with: text) { [self] data in
            searchedData = data
            movieCollectionView.reloadData()
            if movieList.isEmpty == false {
                searchFailedLabel.isHidden = true
                movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            searchBar.resignFirstResponder()
        }
    }
}
