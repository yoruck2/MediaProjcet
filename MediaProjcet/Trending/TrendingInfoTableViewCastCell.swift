//
//  TrendingInfoTableViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 7/1/24.
//

import UIKit
import SnapKit
import Then

class TrendingInfoTableViewCastCell: BaseTableViewCell {
    
    var castData: MovieCredits.Result? {
        didSet {
            configureView()
        }
    }
    
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    let nameLabel = UILabel()

    
    let characterNameLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = Font.regular13
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                characterNameLabel)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(profileImageView.snp.height).multipliedBy(0.7)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView).inset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }
    }
    
    override func configureView() {
        guard let profilePath = castData?.profilePath else {
            return
        }
        let url = URL.make(with: "https://image.tmdb.org/t/p/w200\(profilePath)")
        profileImageView.kf.setImage(with: url)
        nameLabel.text = castData?.name
        characterNameLabel.text = castData?.character
    }
}
