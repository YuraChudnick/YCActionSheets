//
//  YCDatePickerView.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCDatePickerView: YCView {
    
    var callback: ((Date) -> Void)?
    
    public let datePicker: UIDatePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, datePicker])
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                                     stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)])
    }
    
    override func didTapActionButton(_ sender: UIButton) {
        callback.map({ $0(datePicker.date) })
    }
    
}
