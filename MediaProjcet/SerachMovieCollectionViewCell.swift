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
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.addSubview(moviePosterImageView)
        clipsToBounds = true
        configurationLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationLayout() {
        moviePosterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
    
    func setUpData() {
        
        guard let poster = cellData?.posterPath else {
            print("이미지 없음")
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        moviePosterImageView.kf.setImage(with: url)
        print("이미지 있음")
    }
    
    
}
