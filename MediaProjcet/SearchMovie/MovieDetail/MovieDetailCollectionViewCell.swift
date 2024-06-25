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
    
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
