//
//  YCActionSheetSelectFilialDelegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public protocol YCActionSheetSelectFilialDelegate: class {
    
    func addButtonPressed(reloadData: @escaping (YCReloadType) -> Void)
    
    func actionButtonPressed(with index: Int)
    
    func getNames() -> [String]
    
    func getSelectedNameIndex() -> Int
    
    func getEditActionsForRow(reloadData: @escaping (YCReloadType) -> Void) -> [UITableViewRowAction]
    
}
