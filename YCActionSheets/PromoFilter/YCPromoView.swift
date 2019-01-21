//
//  YCPromoView.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCPromoView: YCView {
    
    //MARK: - Properties
    
    var ressetButtonCallback: (() -> Void)?
    
    /// Reset all selected tags button.
    public let resetButton: UIButton = {
        let b = UIButton(type: .system)
        b.setAttributedTitle(NSAttributedString(string: "Reset", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.darkGray]), for: .normal)
        b.contentHorizontalAlignment = .right
        return b
    }()
    
    public var resetButtonSize: CGSize = CGSize(width: 70, height: 30) {
        didSet {
            resetButtonHeightConstraint.constant = resetButtonSize.height
            resetButtonWidthConstraint.constant = resetButtonSize.width
        }
    }
    
    public var resetButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 21) {
        didSet {
            resetButtonTopConstraint.constant = resetButtonInsets.top
            resetButtonRightConstraint.constant = resetButtonInsets.right
        }
    }
    
    private var resetButtonHeightConstraint: NSLayoutConstraint!
    private var resetButtonWidthConstraint: NSLayoutConstraint!
    private var resetButtonTopConstraint: NSLayoutConstraint!
    private var resetButtonRightConstraint: NSLayoutConstraint!
    
    /// Collection view which contains tags.
    public let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: YCLeftAlignedCollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    public var collectionViewInsets: UIEdgeInsets = .zero
    
    var collectionViewHeight: CGFloat = 0 {
        didSet {
            collectionViewHeightConstraint?.isActive = false
            collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
            collectionViewHeightConstraint?.isActive = true
        }
    }
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    //MARK: - Setup views
    
    fileprivate func setupViews() {
        contentView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        resetButtonHeightConstraint = resetButton.heightAnchor.constraint(equalToConstant: resetButtonSize.height)
        resetButtonWidthConstraint = resetButton.widthAnchor.constraint(equalToConstant: resetButtonSize.width)
        resetButtonTopConstraint = resetButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: resetButtonInsets.top)
        resetButtonRightConstraint = resetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -resetButtonInsets.right)
        
        NSLayoutConstraint.activate([resetButtonHeightConstraint,
                                     resetButtonWidthConstraint,
                                     resetButtonTopConstraint,
                                     resetButtonRightConstraint])
        
        resetButton.addTarget(self, action: #selector(resetButtonPressed(_:)), for: .touchUpInside)
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: collectionViewInsets.top),
                                     //collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -collectionViewInsets.bottom),
                                     collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: collectionViewInsets.left),
                                     collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -collectionViewInsets.right)])
        
    }
    
    func updateCollectionViewHeight() {
        collectionViewHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    /// Calculate view height like wrap content.
    func getSumHeight() -> CGFloat {
        var height = actionButtonHeight + actionButtonInsets.top + actionButtonInsets.bottom + contentViewInsets.top + contentViewInsets.bottom + collectionViewInsets.top + collectionViewInsets.bottom + collectionViewHeight + resetButtonSize.height + resetButtonInsets.top
        height += Utils.getSafeAreaBottomInset()
        return height
    }
    
    //MARK: - Actions
    
    @objc private func resetButtonPressed(_ sender: UIButton) {
        ressetButtonCallback.map({ $0() })
    }
    
}
