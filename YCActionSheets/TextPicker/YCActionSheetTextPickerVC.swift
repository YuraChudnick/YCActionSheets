//
//  YCActionSheetTextPickerVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/18/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetTextPickerVC: YCActionSheetVC {
    
    public weak var delegate: YCActionSheetTextPickerDelegate?
    
    public let textPickerView: YCTextPickerView = YCTextPickerView()
    
    public var textPickerTitleParameters: [NSAttributedString.Key : Any] = [ : ]
    
    public var textPickerRowHeight: CGFloat = 35

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    fileprivate func setupViews() {
        conteinerView.addSubview(textPickerView)
        textPickerView.anchor(to: conteinerView, padding: .zero)
        
        updateConteinerViewHeight()
        
        textPickerView.textPicker.dataSource = self
        textPickerView.textPicker.delegate = self
        
        textPickerView.saveButtonCallback = { [weak self] in
            self?.delegate?.saveButtonPressed(textPicker: self?.textPickerView.textPicker.selectedRow(inComponent: 0) ?? 0)
            self?.hideConteinerView()
        }
        
        textPickerView.textPicker.selectRow(delegate?.textPickerSelectedTitleIndex() ?? 0, inComponent: 0, animated: false)
    }
    
    public func updateConteinerViewHeight(with value: CGFloat = 240) {
        _ = setConteinerViewHeight(with: value + Utils.getSafeAreaBottomInset())
    }
    
}

extension YCActionSheetTextPickerVC: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delegate?.textPickerTitles().count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return (delegate?.textPickerTitles()[row] != nil) ? NSAttributedString(string: delegate!.textPickerTitles()[row], attributes: textPickerTitleParameters) : nil
    }
}

extension YCActionSheetTextPickerVC: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return textPickerRowHeight
    }
    
}
