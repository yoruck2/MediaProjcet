//
//  TrendView.swift
//  MediaProjcet
//
//  Created by dopamint on 6/30/24.
//

import UIKit

import SnapKit
import Then

class TrendView: BaseView {
    
    let shadowView = UIView().then {
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = .init(width: 5, height: 5)
        $0.layer.masksToBounds = false
    }
    let backView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    let backImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "star")
    }
    let rateView = UIImageView().then {
        $0.backgroundColor = .purple
    }
    let halfView = UILabel()
    
    let descriptionView = UIView().then {
        $0.backgroundColor = .black
    }
    let titleLabel = UILabel().then {
        $0.text = "dfdfsdfdfdd"
        $0.textColor = .white
        $0.font = Font.regular20
    }
    let castLabel = UILabel().then {
        $0.text = "ddasfsafsadfdsfd"
        $0.textColor = .gray
    }
    let borderLine = UIView().then {
        $0.backgroundColor = .white
//        $0.layer.borderColor = UIColor(named: "white")?.cgColor
//        $0.layer.borderWidth = 1
    }
    let detailLabel = UILabel().then {
        $0.text = "ddd"
        $0.textColor = .white
    }
    let indicatorSymbol = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .white
    }
    override func configureHierarchy() {
        addSubviews(shadowView)
        shadowView.addSubviews(backView)
        backView.addSubviews(backImageView)
        
        backImageView.addSubviews(rateView)
        backImageView.addSubviews(halfView)
        backImageView.addSubviews(descriptionView)
        
        descriptionView.addSubviews(titleLabel)
        descriptionView.addSubviews(castLabel)
        descriptionView.addSubviews(borderLine)
        descriptionView.addSubviews(detailLabel)
        descriptionView.addSubviews(indicatorSymbol)
    }
    override func configureLayout() {
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        backView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
//            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.85)
        }
        rateView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(descriptionView.snp.top).offset(-10)
        }
        halfView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(rateView)
            make.width.equalTo(rateView.snp.width).multipliedBy(0.5)
        }
        descriptionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.33)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(descriptionView).inset(15)
            make.top.equalTo(descriptionView).inset(15)
        }
        castLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        borderLine.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(15)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.93)
            make.height.equalTo(1)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(borderLine.snp.bottom).offset(10)
            make.leading.equalTo(castLabel)
        }
        indicatorSymbol.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(detailLabel)
            make.trailing.equalTo(borderLine)
        }
        
    }
    override func configureView() {
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        layer.shadowOffset = .init(width: 5, height: 5)
        layer.shadowColor = UIColor(named: "white")?.cgColor
        layer.masksToBounds = false
    }
}
