//
//  UIView+.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import UIKit

extension UIView {
    static var id: String {
        return String(describing: self)
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
