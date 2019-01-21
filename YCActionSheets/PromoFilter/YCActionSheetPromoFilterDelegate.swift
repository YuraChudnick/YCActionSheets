//
//  YCActionSheetPromoFilterDelegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

@objc public protocol YCActionSheetPromoFilterDelegate: class {
    
    /// Delegate to get object items for filling collection view
    @objc optional func getItems() -> [YCItemProtocol]
    
    /// Delegate to get string items for filling collection view
    @objc optional func getSItems() -> [String]
    
    /// Delegate to get selected string items
    @objc optional func getSelectedSItems() -> [String]
    
    /// Delegate which will call when tag select
    @objc func didSelectItem(at indexPath: IndexPath)
    
    /// Delegate which will call when tag unselect
    @objc func didDeselectItem(at indexPath: IndexPath)
    
    /// Delegate which will call when reset button is pressed
    @objc func resetButtonPressed()
    
    /// Delegate which will call when action button is pressed
    @objc func actionButtonPressed()
    
}
