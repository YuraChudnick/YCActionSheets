//
//  LeftAlignedCollectionViewFlowLayout.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

class YCLeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        setup()
    }
    
    fileprivate func setup() {
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.sectionInset = UIEdgeInsets.init(top: 16, left: 9, bottom: 16, right: 9)
        self.minimumLineSpacing = 11
        self.minimumInteritemSpacing = 14
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
