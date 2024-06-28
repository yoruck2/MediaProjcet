//
//  dd.swift
//  MediaProjcet
//
//  Created by dopamint on 6/28/24.
//

class BaseTableViewCell: UITableViewCell {
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    
    // 모든 iOS버전에서 사용하지 않겠다
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
