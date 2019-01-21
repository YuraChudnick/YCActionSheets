//
//  YCSelectFilialView.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCSelectFilialView: YCView {
    
    //MARK: - Properties
    
    var addButtonCallback: (() -> Void)?
    
    public let addButton: UIButton = {
        let b = UIButton(type: .system)
        b.setAttributedTitle(NSAttributedString(string: "Add", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.darkText]), for: .normal)
        b.setImage(Utils.imageNamed("plus_ic"), for: .normal)
        b.tintColor = .orange
        b.imageView?.contentMode = .scaleAspectFit
        b.imageEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 20)
        return b
    }()
    
    public var addButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0) {
        didSet {
            addButtonBottomConstaint.constant = addButtonInsets.bottom
            addButtonLeftConstaint.constant = addButtonInsets.left
            addButtonRightConstaint.constant = -addButtonInsets.right
        }
    }
    
    public var addButtonHeight: CGFloat = 50 {
        didSet {
            addButtonHeightConstaint.constant = addButtonHeight
        }
    }
    
    private var addButtonLeftConstaint: NSLayoutConstraint!
    private var addButtonRightConstaint: NSLayoutConstraint!
    private var addButtonBottomConstaint: NSLayoutConstraint!
    private var addButtonHeightConstaint: NSLayoutConstraint!
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    public var tableViewInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            tableViewTopConstaint.constant = tableViewInsets.top
            tableViewBottomConstaint.constant = tableViewInsets.bottom
            tableViewLeftConstaint.constant = tableViewInsets.left
            tableViewRightConstaint.constant = -tableViewInsets.right
        }
    }
    
    private var tableViewTopConstaint: NSLayoutConstraint!
    private var tableViewBottomConstaint: NSLayoutConstraint!
    private var tableViewLeftConstaint: NSLayoutConstraint!
    private var tableViewRightConstaint: NSLayoutConstraint!
    
    public var titleLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0) {
        didSet {
            titleLabelTopConstaint.constant = titleLabelInsets.top
            titleLabelLeftConstaint.constant = titleLabelInsets.left
            titleLabelRightConstaint.constant = -titleLabelInsets.right
        }
    }
    
    public var titleLabelHeight: CGFloat = 30 {
        didSet {
            titleLabelHeightConstaint.constant = titleLabelHeight
        }
    }
    
    private var titleLabelLeftConstaint: NSLayoutConstraint!
    private var titleLabelRightConstaint: NSLayoutConstraint!
    private var titleLabelTopConstaint: NSLayoutConstraint!
    private var titleLabelHeightConstaint: NSLayoutConstraint!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    //MARK: - Setup views
    
    fileprivate func setupViews() {
        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButtonLeftConstaint = addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: addButtonInsets.left)
        addButtonRightConstaint = addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -addButtonInsets.right)
        addButtonBottomConstaint = addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -addButtonInsets.bottom)
        addButtonHeightConstaint = addButton.heightAnchor.constraint(equalToConstant: addButtonHeight)
        
        NSLayoutConstraint.activate([addButtonLeftConstaint,
                                     addButtonRightConstaint,
                                     addButtonBottomConstaint,
                                     addButtonHeightConstaint])
        
        addButton.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelLeftConstaint = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        titleLabelRightConstaint = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        titleLabelTopConstaint = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        titleLabelHeightConstaint = titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight)
        
        NSLayoutConstraint.activate([titleLabelLeftConstaint,
                                     titleLabelRightConstaint,
                                     titleLabelTopConstaint,
                                     titleLabelHeightConstaint])
        
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewLeftConstaint = tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: tableViewInsets.left)
        tableViewRightConstaint = tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -tableViewInsets.right)
        tableViewTopConstaint = tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: tableViewInsets.top)
        tableViewBottomConstaint = tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: tableViewInsets.bottom)
        
        NSLayoutConstraint.activate([tableViewLeftConstaint,
                                     tableViewRightConstaint,
                                     tableViewTopConstaint,
                                     tableViewBottomConstaint])
    }
    
    /// Calculate view height
    func getSumHeight() -> CGFloat {
        var height = titleLabelInsets.top + titleLabelInsets.bottom + addButtonInsets.top + addButtonInsets.bottom +
            tableViewInsets.top + tableViewInsets.bottom + actionButtonHeight + actionButtonInsets.top + actionButtonInsets.bottom + contentViewInsets.top + contentViewInsets.bottom + titleLabelHeight + addButtonHeight
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            height += window?.safeAreaInsets.bottom ?? 0
        }
        return height
    }
    
    //MARK: - Actions
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        addButtonCallback.map({ $0() })
    }
    
    public func setTitleAddButton(with title: String) {
        addButton.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.darkText]), for: .normal)
    }
    
}
