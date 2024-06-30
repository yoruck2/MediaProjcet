//
//  TrendingCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

import SnapKit
import Then

class TrendingTableViewCell: BaseTableViewCell {
    
    var cellData: Trending.Result?
    
    lazy var dateLabel = UILabel().then {
        $0.text = "asd"
    }
    lazy var genreLabel = UILabel().then {
        $0.text = "asd"
    }
    lazy var trendView = TrendView()
    
    override func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(trendView)
    }
    
    override func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel).offset(5)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        
        trendView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
        }
    }
    override func configureView() {
        <#code#>
    }
}
