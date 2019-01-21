//
//  YCActionSheetSelectFilialDelegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public protocol YCActionSheetSelectFilialDelegate: class {
    
    /// Data source for table view
    func getNames() -> [String]
    
    /// Selected item index from items list
    func getSelectedNameIndex() -> Int
    
    /// Action button pressed
    /// - parameter reloadData: reload data in table with animation type add
    func addButtonPressed(reloadData: @escaping (YCReloadType) -> Void)
    
    /// Edit actions for table view
    /// - parameter reloadData: reload data in table with animation type delete
    func getEditActionsForRow(reloadData: @escaping (YCReloadType) -> Void) -> [UITableViewRowAction]
    
    /// Action button pressed
    /// - parameter index: selected item index from list
    func actionButtonPressed(with index: Int)
    
}
