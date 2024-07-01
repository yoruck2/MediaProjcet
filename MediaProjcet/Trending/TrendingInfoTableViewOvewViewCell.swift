//
//  TrendingInfoTableViewOvewViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 7/1/24.
//

import UIKit
import SnapKit
import Then

protocol ReadmoreButtonDelegate {
    func toggleReadme()
}

class TrendingInfoTableViewOverViewCell: BaseTableViewCell {
    
    var delegate: ReadmoreButtonDelegate?
    
    let overViewLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    lazy var readmoreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        $0.addTarget(self, action: #selector(readmeMoreButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func readmeMoreButtonTapped() {
        readmoreButton.isSelected.toggle()
        delegate?.toggleReadme()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(overViewLabel)
        contentView.addSubview(readmoreButton)
    }
    override func configureLayout() {
        overViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(readmoreButton.snp.top)
        }
        readmoreButton.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
