//
//  YCActionSheetTextPickerDlegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/18/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public protocol YCActionSheetTextPickerDelegate: class {
    
    /// Return titles for text picker
    func textPickerTitles() -> [String]
    
    /// Return selected value index
    func textPickerSelectedTitleIndex() -> Int
    
    /// Handler when save button pressed
    /// - parameter row: Selected value index on text picker
    func saveButtonPressed(textPicker row: Int)
    
}
