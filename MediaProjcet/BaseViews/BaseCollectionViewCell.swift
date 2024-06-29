//
//  BaseCollectionViewCell.swift
//  MediaProjcet
//
//  Created by dopamint on 6/28/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero )
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    // 모든 iOS버전에서 사용하지 않겠다
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
