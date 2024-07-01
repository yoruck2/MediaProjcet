//
//  MovieDetailViewController.swift
//  MediaProjcet
//
//  Created by dopamint on 7/1/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class TrendingInfoViewController: BaseViewController {
    
    var movieData: Trending.Result?
    var castList: [MovieCredits.Result]? {
        didSet {
            movieInfoTableView.reloadData()
        }
    }
    
    lazy var backdropImageView = UIImageView().then {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(backdropImageViewTapped))
        $0.addGestureRecognizer(tapGestureRecognizer)
        $0.isUserInteractionEnabled = true
    }
    @objc
    func backdropImageViewTapped() {
        let nextVC = TrendingMovieVideoViewController()
        nextVC.movieID = movieData?.id ?? 0
        navigationController?.pushViewController(nextVC, animated: true)
    }
    let shadowView = BaseView().then {
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 3
        $0.layer.shadowOffset = .init(width: 0, height: 0)
        $0.layer.shadowColor = UIColor(named: "black")?.cgColor
        $0.layer.masksToBounds = false
    }
    let titleLabel = UILabel().then {
        $0.text = "Squid Game"
        $0.font = Font.bold25
        $0.textColor = .white
    }
    let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "star")
    }
    lazy var movieInfoTableView = UITableView().then {
        $0.separatorColor = .lightGray
        $0.rowHeight = 100
        $0.delegate = self
        $0.dataSource = self
        $0.register(TrendingInfoTableViewCastCell.self, forCellReuseIdentifier: TrendingInfoTableViewCastCell.id)
    }
    
    override func loadView() {
        super.loadView()
        guard let backdropPath = movieData?.backdropPath,
              let posterPath = movieData?.posterPath
        else {
            return
        }
        titleLabel.text = movieData?.title
        let backdropUrl = URL.make(with: "https://image.tmdb.org/t/p/original\(backdropPath)")
        let posterUrl = URL.make(with: "https://image.tmdb.org/t/p/w500\(posterPath)")
        backdropImageView.kf.setImage(with: backdropUrl)
        posterImageView.kf.setImage(with: posterUrl)
    }
    
    override func configureHierarchy() {
        view.addSubviews(backdropImageView,
                         posterImageView,
                         movieInfoTableView,
                         shadowView)
        shadowView.addSubviews(titleLabel)
    }
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        shadowView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(backdropImageView).inset(20)
        }
        titleLabel.snp.makeConstraints { make in
//            make.center.equalTo(backdropImageView)
            make.edges.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(backdropImageView.snp.bottom).inset(10)
            make.leading.equalTo(titleLabel).inset(5)
            make.width.equalTo(backdropImageView.snp.width).multipliedBy(0.25)
//            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        movieInfoTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(backdropImageView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        navigationItem.title = "출연/제작"
    }
}

extension TrendingInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "개요"
        case 1:
            return "출연진"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section != 0 else {
            return 1
        }
        return castList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section != 0 else {
            return tableView.estimatedRowHeight
        }
        return 100
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section != 0 else {
            let cell = TrendingInfoTableViewOverViewCell()
            cell.selectionStyle = .none
            cell.overViewLabel.text = movieData?.overview
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingInfoTableViewCastCell.id, for: indexPath) as? TrendingInfoTableViewCastCell
        else {
            return UITableViewCell()
        }
        print(indexPath)
        cell.castData = castList?[indexPath.row]
        return cell
    }
    
    
}

//extension TrendingInfoViewController: ReadmoreButtonDelegate {
//    func toggleReadme(completion: () -> Void) {
//        completion
//    }
//}
