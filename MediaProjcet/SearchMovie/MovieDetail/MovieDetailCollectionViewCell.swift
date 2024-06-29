//
//  MovieDetailCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import UIKit
import Then
import SnapKit

class MovieDetailCollectionViewCell: BaseCollectionViewCell {
    
    var posterImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
}
