//
//  TrendingCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/12/24.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    var cellData: TrendingDTO?
    
    lazy var dateLabel = {
        let view = UILabel()
        
        return view
    }()
    
    lazy var genreLabel = {
        let view = UILabel()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var imageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        
        
        return view
    }()
   
//    lazy var _ = {
//        let view = UIImageView()
//        view.backgroundColor = .gray
//        
//        return view
//    }    
//    lazy var _ = {
//        let view = UIImageView()
//        view.backgroundColor = .gray
//        
//        return view
//    }    
//    lazy var _ = {
//        let view = UIImageView()
//        view.backgroundColor = .gray
//        
//        return view
//    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .lightGray
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
