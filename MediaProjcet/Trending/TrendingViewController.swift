//
//  TrendingViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

import Alamofire
import SnapKit

class TrendingViewController: BaseViewController {
    
    let network = TMDBAPI.shared
    var trendingList: [Trending.Result] = []
    
    lazy var trendingTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
//        $0.prefetchDataSource = self
        $0.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        $0.rowHeight = 450
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.request(api: .trending(type: .Movie, language: .korean), model: Trending.self) { [self] data, error in
            trendingList = data?.results ?? []
        }
    }
    
    override func configureHierarchy() {
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

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id, 
                                                       for: indexPath) as? TrendingTableViewCell
        else {
            return UITableViewCell()
        }
        
//        cell.cellData = trendingList[indexPath.row]
        
        return cell
    }
    
    
}
