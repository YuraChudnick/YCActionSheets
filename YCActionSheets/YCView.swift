//
//  YCView.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCView: UIView {
    
    public let actionButton: YCButton = {
        let b = YCButton()
        b.backgroundColor = .orange
        b.titleLabel.text = "Action"
        b.titleLabel.textColor = .white
        return b
    }()
    
    var actionButtonCallback: (() -> Void)?
    
    public var actionButtonHeight: CGFloat = 50 {
        didSet {
            updateActionButtonConstraint()
        }
    }
    
    public var actionButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10) {
        didSet {
            updateActionButtonConstraint()
        }
    }
    
    public var actionButtonCornerRadius: CGFloat = 25 {
        didSet {
            actionButton.layer.cornerRadius = actionButtonCornerRadius
        }
    }
    
    public let contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    public var contentViewCornerRadius: CGFloat = 10 {
        didSet {
            contentView.layer.cornerRadius = contentViewCornerRadius
        }
    }
    
    public var contentViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10) {
        didSet {
            updateContentViewConstraints()
        }
    }
    
    public let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Title"
        l.textColor = UIColor.darkGray
        l.textAlignment = .center
        return l
    }()
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.layer.cornerRadius = actionButtonCornerRadius
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)
        updateActionButtonConstraint()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = contentViewCornerRadius
        contentView.layer.masksToBounds = true
        updateContentViewConstraints()
    }
    
    fileprivate func updateActionButtonConstraint() {
        if actionButton.superview != nil { actionButton.removeFromSuperview() }
        addSubview(actionButton)
        if #available(iOS 11.0, *) {
            actionButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: actionButtonInsets, size: CGSize(width: 0, height: actionButtonHeight))
        } else {
            actionButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: actionButtonInsets, size: CGSize(width: 0, height: actionButtonHeight))
        }
    }
    
    fileprivate func updateContentViewConstraints() {
        if contentView.superview != nil { contentView.removeFromSuperview() }
        addSubview(contentView)
        contentView.anchor(top: topAnchor, leading: leadingAnchor, bottom: actionButton.topAnchor, trailing: trailingAnchor, padding: contentViewInsets)
    }
    
    @objc func didTapActionButton(_ sender: UIButton) {
        actionButtonCallback.map({ $0() })
    }
    
}
