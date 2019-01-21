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
            actionButtonHeightConstraint.constant = actionButtonHeight
        }
    }
    
    public var actionButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10) {
        didSet {
            actionButtonLeftConstraint.constant = actionButtonInsets.left
            actionButtonRightConstraint.constant = -actionButtonInsets.right
            actionButtonBottomConstraint.constant = -actionButtonInsets.bottom
        }
    }
    
    public var actionButtonCornerRadius: CGFloat = 25 {
        didSet {
            actionButton.layer.cornerRadius = actionButtonCornerRadius
        }
    }
    
    private var actionButtonHeightConstraint: NSLayoutConstraint!
    private var actionButtonLeftConstraint: NSLayoutConstraint!
    private var actionButtonRightConstraint: NSLayoutConstraint!
    private var actionButtonBottomConstraint: NSLayoutConstraint!
    
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
            contentViewLeftConstraint.constant = contentViewInsets.left
            contentViewRightConstraint.constant = -contentViewInsets.right
            contentViewTopConstraint.constant = contentViewInsets.top
            contentViewBottomConstraint.constant = -contentViewInsets.bottom
        }
    }
    
    private var contentViewLeftConstraint: NSLayoutConstraint!
    private var contentViewRightConstraint: NSLayoutConstraint!
    private var contentViewTopConstraint: NSLayoutConstraint!
    private var contentViewBottomConstraint: NSLayoutConstraint!
    
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
        addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.layer.cornerRadius = actionButtonCornerRadius
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)
        
        actionButtonHeightConstraint = actionButton.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        actionButtonLeftConstraint = actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: actionButtonInsets.left)
        actionButtonRightConstraint = actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -actionButtonInsets.right)
        
        if #available(iOS 11.0, *) {
            actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -actionButtonInsets.bottom)
        } else {
            actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -actionButtonInsets.bottom)
        }
        
        NSLayoutConstraint.activate([actionButtonHeightConstraint, actionButtonLeftConstraint, actionButtonRightConstraint, actionButtonBottomConstraint])
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = contentViewCornerRadius
        contentView.layer.masksToBounds = true
        
        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: contentViewInsets.top)
        contentViewLeftConstraint = contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentViewInsets.left)
        contentViewRightConstraint = contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentViewInsets.right)
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -contentViewInsets.bottom)
        
        NSLayoutConstraint.activate([contentViewTopConstraint, contentViewLeftConstraint, contentViewRightConstraint, contentViewBottomConstraint])
    }
    
    @objc func didTapActionButton(_ sender: UIButton) {
        actionButtonCallback.map({ $0() })
    }
    
}
