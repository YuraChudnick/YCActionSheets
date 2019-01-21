//
//  UIView+Extensions.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func anchor(to view: UIView, padding: UIEdgeInsets) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
                                     self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
                                     self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right),
                                     self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)])
    }
    
}
