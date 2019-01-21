//
//  YCTextPickerView.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/18/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCTextPickerView: UIView {
    
    var saveButtonCallback: (() -> Void)?
    
    public let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Save", for: .normal)
        b.setTitleColor(UIColor.orange, for: .normal)
        return b
    }()

    public var saveButtonSize: CGSize = CGSize(width: 100, height: 50) {
        didSet {
            saveButtonHeightConstaint.constant = saveButtonSize.height
            saveButtonWidthConstaint.constant = saveButtonSize.width
        }
    }
    
    public var saveButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            saveButtonTopConstaint.constant = saveButtonInsets.top
            saveButtonRightConstaint.constant = -saveButtonInsets.right
        }
    }

    private var saveButtonTopConstaint: NSLayoutConstraint!
    private var saveButtonRightConstaint: NSLayoutConstraint!
    private var saveButtonHeightConstaint: NSLayoutConstraint!
    private var saveButtonWidthConstaint: NSLayoutConstraint!
    
    public let textPicker: UIPickerView =  UIPickerView()
    
    public var textPickerInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 20, right: 24) {
        didSet {
            textPickerTopConstaint.constant = textPickerInsets.top
            textPickerBottomConstaint.constant = -textPickerInsets.bottom
            textPickerLeftConstaint.constant = textPickerInsets.left
            textPixkerRightConstaint.constant = -textPickerInsets.right
        }
    }

    private var textPickerTopConstaint: NSLayoutConstraint!
    private var textPickerBottomConstaint: NSLayoutConstraint!
    private var textPickerLeftConstaint: NSLayoutConstraint!
    private var textPixkerRightConstaint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .white
        
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButtonHeightConstaint = saveButton.heightAnchor.constraint(equalToConstant: saveButtonSize.height)
        saveButtonWidthConstaint = saveButton.widthAnchor.constraint(equalToConstant: saveButtonSize.width)
        saveButtonTopConstaint = saveButton.topAnchor.constraint(equalTo: topAnchor, constant: saveButtonInsets.top)
        saveButtonRightConstaint = saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -saveButtonInsets.right)
        
        NSLayoutConstraint.activate([saveButtonHeightConstaint, saveButtonWidthConstaint, saveButtonTopConstaint, saveButtonRightConstaint])
        
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        
        addSubview(textPicker)
        textPicker.translatesAutoresizingMaskIntoConstraints = false
        
        textPickerTopConstaint = textPicker.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: textPickerInsets.top)
        if #available(iOS 11.0, *) {
            textPickerBottomConstaint = textPicker.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -textPickerInsets.bottom)
        } else {
            textPickerBottomConstaint = textPicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -textPickerInsets.bottom)
        }
        textPickerLeftConstaint = textPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textPickerInsets.left)
        textPixkerRightConstaint = textPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textPickerInsets.right)
        
        NSLayoutConstraint.activate([textPickerTopConstaint, textPickerBottomConstaint, textPickerLeftConstaint, textPixkerRightConstaint])
    }
    
    @objc private func saveButtonPressed(_ sender: UIButton) {
        saveButtonCallback.map({ $0() })
    }
    
}
