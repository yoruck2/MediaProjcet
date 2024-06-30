//
//  TrendingCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

import Kingfisher
import SnapKit
import Then

class TrendingTableViewCell: BaseTableViewCell {
    
    var movieData: Trending.Result? {
        didSet {
            configureView()
        }
    }
    var castData: MovieCredits?
    
    lazy var dateLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    lazy var genreLabel = UILabel().then {
        $0.text = "#장르"
        $0.font = Font.bold20
    }
    lazy var trendView = TrendView()
    
    override func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(trendView)
    }
    
    override func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom)
        }
        
        trendView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
        }
    }
    override func configureView() {
        selectionStyle = .none
        guard let backdropPath = movieData?.backdropPath else {
            return
        }
        let url = URL.make(with: "https://image.tmdb.org/t/p/original\(backdropPath)")
        dateLabel.text = movieData?.releaseDate
        trendView.backImageView.kf.setImage(with: url)
        trendView.rateValueView.text = " \(round((movieData?.voteAverage ?? 0) * 10) / 10) "
        trendView.titleLabel.text = movieData?.title
        trendView.castLabel.text = ""
        for i in 0...4 {
            guard var labelText = trendView.castLabel.text,
                    var name = castData?.cast?[i].name else {
                return
            }
            labelText += name + ", "
            trendView.castLabel.text = labelText
        }
    }
}
