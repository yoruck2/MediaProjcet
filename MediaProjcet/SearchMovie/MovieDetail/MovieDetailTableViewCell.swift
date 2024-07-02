//
//  MovieDetailTableViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import UIKit

import SnapKit
import Then

final class MovieDetailTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "제안드릴 영화가 없네요"
        $0.textColor = .white
        $0.font = Font.bold13
        $0.isHidden = true
    }
    
    lazy var movieCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: collectionViewLayout())
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        // TODO: 인디케이터 왜 안없어짐??
        layout.collectionView?.showsHorizontalScrollIndicator = false
        return layout
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(movieCollectionView)
        contentView.addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(movieCollectionView.snp.center)
        }
    }
}
