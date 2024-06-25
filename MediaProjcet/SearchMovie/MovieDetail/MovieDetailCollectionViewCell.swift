//
//  MovieDetailCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {
    
    var posterImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        layer.cornerRadius = 10
//        clipsToBounds = true
//    }
}
