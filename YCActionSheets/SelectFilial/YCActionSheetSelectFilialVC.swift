//
//  YCActionSheetSelectFilialVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetSelectFilialVC: YCActionSheetVC {
    
    //MARK: - Properties

    public weak var delegate: YCActionSheetSelectFilialDelegate?
    
    public let selectFilialView = YCSelectFilialView()
    
    public var checkedImage: UIImage = Utils.imageNamed("ratio_btn_checked")
    
    public var uncheckedImage: UIImage = Utils.imageNamed("ratio_btn_unchecked")
    
    private let cellId = "YCSelectFilialCell"
    
    private var selectedItemIndex: Int = 0
    
    public var tableViewCellHeight: CGFloat = 52 {
        didSet {
            reloadData(with: .all)
        }
    }
    
    /// Max items in table view, when it max add button will disable.
    public var maxItems: Int = 5 {
        didSet {
            guard let d = delegate else { return }
            selectFilialView.addButton.isEnabled = d.getNames().count <= maxItems
        }
    }
    
    /// Enable scrollinf in table view.
    public var isTableViewScrollingEnabled: Bool = false {
        didSet {
            selectFilialView.tableView.isScrollEnabled = isTableViewScrollingEnabled
        }
    }
    
    // MARK: - View lifecycles
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelectFilialView()
        selectedItemIndex = delegate?.getSelectedNameIndex() ?? 0
        reloadData(with: .all)
    }
    
    // MARK: - Setup views
    
    fileprivate func setupSelectFilialView() {
        conteinerView.addSubview(selectFilialView)
        selectFilialView.anchor(to: conteinerView
            , padding: .zero)
        
        selectFilialView.tableView.delegate = self
        selectFilialView.tableView.dataSource = self
        selectFilialView.tableView.register(YCSelectFilialCell.self, forCellReuseIdentifier: cellId)
        selectFilialView.tableView.isScrollEnabled = isTableViewScrollingEnabled
        
        selectFilialView.addButtonCallback = { [weak self] in
            self?.delegate?.addButtonPressed(reloadData: { [weak self] type in
                self?.reloadData(with: type)
            })
        }
        
        selectFilialView.actionButtonCallback = { [weak self] in
            self?.delegate?.actionButtonPressed(with: self?.selectedItemIndex ?? 0)
            self?.hideConteinerView()
        }
        
        standardSpacing = 90
    }
    
    // MARK: - Actions
    
    private func reloadData(with type: YCReloadType) -> Void {
        let cellCount = CGFloat(delegate?.getNames().count ?? 0)
        let height = cellCount == 0 ? selectFilialView.getSumHeight() : (cellCount * tableViewCellHeight + selectFilialView.getSumHeight())
        let overSize = setConteinerViewHeight(with: height)
        selectFilialView.tableView.isScrollEnabled = overSize > 0
        
        selectFilialView.tableView.isEditing = false

        switch type {
        case .add:
            selectFilialView.tableView.beginUpdates()
            if let d = delegate {
                selectFilialView.tableView.insertRows(at: [IndexPath(row: d.getNames().count - 1, section: 0)], with: .left)
            }
            selectFilialView.tableView.endUpdates()
        case .delete(let indexPath):
            selectFilialView.tableView.beginUpdates()
            selectFilialView.tableView.deleteRows(at: [indexPath], with: .automatic)
            selectFilialView.tableView.endUpdates()
            if indexPath.row == selectedItemIndex && (delegate?.getNames().count ?? 0) != 0 {
                selectedItemIndex = 0
                if let cell = selectFilialView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? YCSelectFilialCell {
                    cell.imgView.image = checkedImage
                }
            } else if indexPath.row < selectedItemIndex {
                selectedItemIndex = selectedItemIndex - 1
            }
        case .all:
            selectFilialView.tableView.reloadData()
        }
        
        guard let d = delegate else { return }
        selectFilialView.addButton.isEnabled = d.getNames().count < maxItems
    }

}

extension YCActionSheetSelectFilialVC: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getNames().count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! YCSelectFilialCell
        cell.titleLabel.text = delegate?.getNames()[indexPath.row]
        cell.imgView.image = selectedItemIndex == indexPath.row ? checkedImage : uncheckedImage

        return cell
    }
    
}

extension YCActionSheetSelectFilialVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return delegate?.getEditActionsForRow(reloadData: { [weak self] type in
            self?.reloadData(with: type)
        })
    }
}


