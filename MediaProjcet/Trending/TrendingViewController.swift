//
//  TrendingViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

import Alamofire
import SnapKit

final class TrendingViewController: BaseViewController {
    
    let network = TMDBAPI.shared
    private var trendingList: [Trending.Result] = [] {
        didSet {
            trendingTableView.reloadData()
        }
    }
    private var creditData: MovieCredits?
    private var movieGenreList: [Genre]?
    
    private lazy var trendingTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
//        $0.prefetchDataSource = self
        $0.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        $0.rowHeight = 450
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.request(api: .trending(type: .Movie, 
                                       language: .korean),
                        model: Trending.self) { [self] data, error in
            trendingList = data?.results ?? []
            trendingTableView.reloadData()
        } 
        
        network.request(api: .movieGenre(language: .korean), model: MovieGenre.self) { data,_ in
            self.movieGenreList = data?.genres
        }
 
    }
    
    override  func configureHierarchy() {
        view.addSubview(trendingTableView)
    }
    override func configureLayout() {
        trendingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
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
    private func searchItemTapped() {
        self.present(SearchMovieViewController(), animated: true)
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id, 
                                                       for: indexPath) as? TrendingTableViewCell
        else {
            return UITableViewCell()
        }
        network.request(api: .credits(movieId: trendingList[indexPath.row].id,
                                      language: .korean),
                        model: MovieCredits.self) { [self] data, _ in
            creditData = data

        }
        movieGenreList?.forEach { genre in
            if genre.id == trendingList[indexPath.row].genreIDS[0] {
                cell.genreLabel.text = "#\(genre.name)"
            }
        }
        
        cell.castData = creditData
        cell.movieData = trendingList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TrendingInfoViewController()
        network.request(api: .credits(movieId: trendingList[indexPath.row].id,
                                      language: .korean),
                        model: MovieCredits.self) { [self] data, _ in
            creditData = data
            print(trendingList[indexPath.row].id)
            nextVC.castList = creditData?.cast
            nextVC.movieData = trendingList[indexPath.row]
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension TrendingViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
