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
    
    let backView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    let backImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "star")
    }
    let rateView = UILabel().then {
        $0.backgroundColor = .purple
        $0.text = " 평점 "
    }
    let rateValueView = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    let descriptionView = UIView().then {
        $0.backgroundColor = .black
    }
    let titleLabel = UILabel().then {
        $0.text = "불러오는 중.."
        $0.textColor = .white
        $0.font = Font.regular20
    }
    let castLabel = UILabel().then {
        $0.text = "불러오는 중.."
        $0.textColor = .gray
    }
    let borderLine = UIView().then {
        $0.backgroundColor = .white
    }
    let detailLabel = UILabel().then {
        $0.text = "자세히 보기"
        $0.textColor = .white
    }
    let indicatorSymbol = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .white
    }
    override func configureHierarchy() {
        addSubviews(backView)
        backView.addSubviews(backImageView)
        
        backImageView.addSubviews(descriptionView)
        
        descriptionView.addSubviews(titleLabel)
        descriptionView.addSubviews(castLabel)
        descriptionView.addSubviews(borderLine)
        descriptionView.addSubviews(detailLabel)
        descriptionView.addSubviews(indicatorSymbol)
        backImageView.addSubviews(rateView)
        backImageView.addSubviews(rateValueView)
    }
    override func configureLayout() {

        backView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.85)
        }
        rateView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(descriptionView.snp.top).offset(-10)
        }
        rateValueView.snp.makeConstraints { make in
            make.leading.equalTo(rateView.snp.trailing)
            make.top.equalTo(rateView)
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
            make.leading.trailing.equalTo(titleLabel)
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
        layer.shadowOffset = .init(width: 10, height: 10)
        layer.shadowColor = UIColor(named: "purple")?.cgColor
        layer.masksToBounds = false
    }
}
