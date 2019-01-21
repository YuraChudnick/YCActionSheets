//
//  YCActionSheetPromoFilterDelegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public protocol YCActionSheetPromoFilterDelegate: class {
    
    /// Delegate to get string items for filling collection view
    func getItems() -> [String]
    
    /// Delegate to get selected string items
    func getSelectedItems() -> Set<Int>
    
    /// Delegate which will call when tag select
    func didSelectItem(at indexPath: IndexPath)
    
    /// Delegate which will call when tag unselect
    func didDeselectItem(at indexPath: IndexPath)
    
    /// Delegate which will call when reset button is pressed
    func resetButtonPressed()
    
    /// Delegate which will call when action button is pressed
    func actionButtonPressed()
    
}
