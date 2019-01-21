//
//  YCItemProtocol.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

/// To feel collection view cells, you will need to release this protocol in you data object
@objc public protocol YCItemProtocol {
    
    @objc func getItemName() -> String
    
    @objc func isSelected() -> Bool
    
    @objc func selected(value: Bool)
    
}
