//
//  MovieDetailViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 7/1/24.
//

import UIKit
import SnapKit
import Then

class TrendingInfoViewController: BaseViewController {
    
    var castList: [MovieCredits.Result]?
    
    let backdropImageView = UIImageView().then {
        $0.image = UIImage(named: "star")
    }
    let titleLabel = UILabel().then {
        $0.text = "Squid Game"
        $0.font = Font.bold30
        $0.textColor = .white
    }
    let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "star")
    }
    lazy var movieInfoTableView = UITableView().then {
        $0.estimatedRowHeight = 200
        $0.delegate = self
        $0.dataSource = self
        $0.register(TrendingInfoTableViewCell.self, forCellReuseIdentifier: TrendingInfoTableViewCell.id)
    }
    override func configureHierarchy() {
        view.addSubview(backdropImageView)
        view.addSubview(titleLabel)
        view.addSubview(posterImageView)
        view.addSubview(movieInfoTableView)
    }
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.23)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(backdropImageView).inset(20)
        }
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(backdropImageView.snp.bottom).inset(10)
            make.leading.equalTo(titleLabel).offset(5)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        movieInfoTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.23)
        }
    }
    override func configureView() {
        navigationItem.title = "출연/제작"
    }
}

extension TrendingInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(ddz
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        castList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingInfoTableViewCell.id, for: indexPath) as? TrendingInfoTableViewCell
        else {
            return UITableViewCell()
        }
//        cell = castList?[indexPath.row]
        
        
        return cell
    }
    
    
}
