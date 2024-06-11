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
    var cellData: ResultDTO? {
        didSet {
            setUpData()
        }
    }
    
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
        addSubview(moviePosterImageView)
//        setUpData()
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
        
        guard let poster = cellData?.poster_path else {
            print("시발")
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        print(url)
        moviePosterImageView.kf.setImage(with: url)
    }
    
    
}
