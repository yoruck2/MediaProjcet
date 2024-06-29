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
    
    let network = TMDBAPI.shared
    
    var searchedData: SearchedMovie? {
        didSet {
            guard let data = searchedData?.results, data.isEmpty == false else {
                searchFailedLabel.isHidden = false
                return
            }
            movieList = data
        }
    }
    
    lazy var movieList: [SearchedMovie.Result] = []
    
    var page = 1
    
    let movieSearchBar = {
        let view = UISearchBar()
        view.placeholder = "영화 제목을 검색해보세요"
        return view
    }()
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width / 3, height: width / 3 * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, 
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
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
        configureHierarchy()
        configureLayout()
        cnofigureView()
        setUpCollectionView()
        setUpSearchBar()
    }
    
    func configureHierarchy() {
        view.addSubviews(movieSearchBar,
                         movieCollectionView,
                         movieSearchBar,
                         searchFailedLabel)
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
    
    func cnofigureView() {
        navigationItem.title = "영화 검색"
    }
    
    func setUpCollectionView() {
        movieCollectionView.keyboardDismissMode = .onDrag
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.prefetchDataSource = self
        movieCollectionView.register(SerachMovieCollectionViewCell.self,
                                     forCellWithReuseIdentifier: SerachMovieCollectionViewCell.id)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = MovieDetailViewController()
        vc.movieData = movieList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// TODO: issue: 검색 후 첫 스크롤 시 아주 빠르게 하면 영화가 로드되지 않는 경우가 있다
// index를 확인해보니 증가하다가 갑자기 한자리수로 줄어드는것을 확인, movieList.count 에 도달하지 못하는것이 원인
// why ??
extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPaths in indexPaths {
            
//            print(indexPaths)
//            print(indexPaths.section)
//            print(indexPaths.row)
//            print(indexPaths.item)
//            print("=-=-=-=-=-=-=-=-=-=-")
//            print(movieList.count)
//            
            guard let text = movieSearchBar.text else {
                return
            }
            
            if movieList.count - 4 == indexPaths.item {
                page += 1
                network.request(api: .searchMovie(query: text, page: page),
                                page: page, model: SearchedMovie.self) { data, error in
                    self.movieList.append(contentsOf: data?.results ?? [] )
                    self.movieCollectionView.reloadData()
                }
            }
        }
    }
    
    
}
private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("Cancel Prefetch \(indexPaths)")
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        movieList.removeAll()
        
        guard let text = searchBar.text else {
            return
        }
        network.request(api: .searchMovie(query: text, page: page), model: SearchedMovie.self) { [self] data, error in
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
