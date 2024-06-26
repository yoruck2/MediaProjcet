//
//  SerachMovieCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import UIKit
import Kingfisher
import SnapKit

final class SerachMovieCollectionViewCell: UICollectionViewCell {
    var cellData: SearchedMovie.Result?
    
    lazy var moviePosterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
        configurationLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationLayout() {
        moviePosterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
    
    func setUpData() {
        
        guard let poster = cellData?.posterPath else {
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        moviePosterImageView.kf.setImage(with: url)
    }
    
    
}
