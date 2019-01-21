//
//  YCPromoFilterCell.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

class YCPromoFilterCell: UICollectionViewCell {
    
    var callback: ((Bool) -> Void)?
    
    let tagButton: YCTagButton = {
        let tb = YCTagButton()
        tb.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tb.contentEdgeInsets = UIEdgeInsets(top: 6, left: 17, bottom: 6, right: 17)
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(tagButton)
        tagButton.anchor(to: self, padding: .zero)
        tagButton.addTarget(self, action: #selector(tagTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func tagTapped(_ sender: UIButton) {
        tagButton.isSelected = !tagButton.isSelected
        callback.map({ $0(tagButton.isSelected) })
    }
    
    func setTagButtonSelected(_ selected: Bool, animated: Bool) {
        if animated {
            UIView.transition(with: self.tagButton,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: { self.tagButton.isSelected = selected },
                              completion: nil)
        } else {
            tagButton.isSelected = selected
        }
    }
    
    func setTagButtonTitle(_ title: String) {
        tagButton.setTitle(title, for: .normal)
    }
    
}
