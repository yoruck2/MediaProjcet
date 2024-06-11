//
//  SerachMovieCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import UIKit
import Kingfisher
import SnapKit

class SerachMovieCollectionViewCell: UICollectionViewCell {
    var cellData: ResultDTO?
    
    lazy var moviePosterImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(moviePosterImageView)
        setUpData()
        configurationLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configurationLayout() {
        moviePosterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func setUpData() {
        let url = URL(string: cellData?.poster_path ?? "")
        moviePosterImageView.kf.setImage(with: url)
    }
    
    
}
