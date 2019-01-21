//
//  YCActionSheetTextPickerDlegate.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/18/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public protocol YCActionSheetTextPickerDelegate: class {
    
    func textPickerTitles() -> [String]
    
    func textPickerSelectedTitleIndex() -> Int
    
    func saveButtonPressed(textPicker row: Int)
    
}
