//
//  YCActionSheetDatePickerVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetDatePickerVC: YCActionSheetVC {
    
    /// Delegate to handle selected date.
    public weak var delegate: YCActionSheetDatePickerDelegate?
    
    /// Callback to handle selected date.
    public var callback: ((Date) -> Void)?

    /// View with titleLabel, datePicker and selectButton.
    public let datePickerView = YCDatePickerView()

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePickerView()
    }
    
    fileprivate func setupDatePickerView() {
        conteinerView.addSubview(datePickerView)
        datePickerView.anchor(to: conteinerView, padding: .zero)
        datePickerView.callback = { [weak self] date in
            guard let `self` = self else { return }
            self.delegate.map({ $0.datePicker(selected: date) })
            self.callback.map({ $0(date) })
            self.hideConteinerView()
        }
    }

}
