//
//  TagButton.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCTagButton: UIButton {
    
    public var selectedColor: UIColor = .orange {
        didSet {
            setNeedsDisplay()
        }
    }
    public var unselectedColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }

    override public func draw(_ rect: CGRect) {
        self.tintColor = UIColor.clear
        self.backgroundColor = UIColor.white
        self.cornerRadius = rect.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = selectedColor.cgColor
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.white, for: .selected)
    }
    
    override public var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? selectedColor : unselectedColor
        }
    }
}
