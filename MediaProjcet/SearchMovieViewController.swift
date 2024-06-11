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
            guard let data = searchedData?.results else {
                return
            }
            searchedList = data
            movieCollectionView.reloadData()
        }
    }
    lazy var searchedList: [ResultDTO] = []
    
    var page = 1
    var isEnd = false
    
    let movieSearchBar = {
        let view = UISearchBar()
        view.placeholder = "영화 제목을 검색해보세요"
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()   // tableView.rowHeight 역할
        let width = UIScreen.main.bounds.width - 40
//        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("😛😛")
        
        Network.sendGetRequest(with: "dune") { data in
            
            self.searchedData = data
            self.movieCollectionView.reloadData()
        }
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
    }
    
    func configureLayout() {
        movieSearchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(movieSearchBar.snp.bottom).offset(5)
        }
    }
    
    func configureUI() {
        navigationController?.navigationItem.title = "영화 검색"
    }
    func setUpCollectionView() {
       
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(SerachMovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: SerachMovieCollectionViewCell.id)

        movieCollectionView.backgroundColor = .black
    }
    func setUpSearchBar() {
        movieSearchBar.delegate = self
    }

}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40) / 3
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SerachMovieCollectionViewCell.id, for: indexPath) as! SerachMovieCollectionViewCell
        cell.cellData = searchedList[indexPath.row]
        return cell
    }
}

extension SearchMovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if searchedList.count - 2 == item.row && isEnd == false {
                page += 1
                Network.sendGetRequest(with: movieSearchBar.text ?? "") { data in
                    self.searchedData = data
                }
                
            }
        }
    }
    // 취소 기능 : 단, 직접 취소라는 기능을 구현 해줘야 한다
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        Network.sendGetRequest(with: searchBar.text ?? "") { data in
            self.searchedData = data
        }
        searchBar.resignFirstResponder()
    }
}
