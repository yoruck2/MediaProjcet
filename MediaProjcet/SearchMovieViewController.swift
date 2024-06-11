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
        }
    }
    lazy var searchedList: [ResultDTO] = []
    
    var page = 1
    
    
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
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureUI()
        movieCollectionView.backgroundColor = .black
        
        Network.sendGetRequest(with: "dune") { data in
            self.searchedData = data
            dump(self.searchedData)
        }
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
            $0.top.equalTo(movieSearchBar).offset(5)
        }
    }
    
    func configureUI() {
        navigationController?.navigationItem.title = "영화 검색"
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        guard var data = searchedData else {
            return
        }
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(SerachMovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: SerachMovieCollectionViewCell.id)
        
        view.backgroundColor = .lightGray
        movieCollectionView.backgroundColor = .green
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

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
//        Network.sendGetRequest(with: searchBar.text ?? "", completion: <#(SearchedMovieDTO) -> Void#>)
    }
}
