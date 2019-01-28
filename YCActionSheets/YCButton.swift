//
//  YCButton.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCButton: UIControl {
    
    /// Background color of button, when it did not press.
    public var normalColor: UIColor = .orange {
        didSet {
            backgroundColor = normalColor
        }
    }
    
    /// Backround color if button, when it pressed.
    public var highlightedColor: UIColor = UIColor.orange.withAlphaComponent(0.85)
    
    public let titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return l
    }()
    
    private var animator = UIViewPropertyAnimator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:  aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.fillSuperview()
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    @objc private func touchDown() {
        animator.stopAnimation(true)
        backgroundColor = highlightedColor
        titleLabel.textColor = titleLabel.textColor.withAlphaComponent(0.85)
    }
    
    @objc private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
            self.titleLabel.textColor = self.titleLabel.textColor.withAlphaComponent(1)
        })
        animator.startAnimation()
    }
    
}

