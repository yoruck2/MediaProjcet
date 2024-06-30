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
        
    }
}
