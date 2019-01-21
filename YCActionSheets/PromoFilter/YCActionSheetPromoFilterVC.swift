//
//  YCActionSheetPromoFilterVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetPromoFilterVC: YCActionSheetVC {
    
    //MARK: - Properties
    
    /// Delegate to work with this vc
    public weak var delegate: YCActionSheetPromoFilterDelegate?
    
    /// Content view with collection view, action button and reset button
    public let promoView: YCPromoView = YCPromoView()
    
    private let cellId = "YCPromoFilterCell"
    
    public var tagButtonSelectedColor: UIColor = .orange {
        didSet {
            promoView.collectionView.reloadData()
        }
    }
    public var tagButtonUnselectedColor: UIColor = .white {
        didSet {
            promoView.collectionView.reloadData()
        }
    }

    //MARK: - View lifecycles
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        reloadData()
    }
    
    //MARK: - Setup Views
    
    fileprivate func setupViews() {
        conteinerView.addSubview(promoView)
        promoView.anchor(to: conteinerView
            , padding: .zero)
        
        promoView.collectionView.dataSource = self
        promoView.collectionView.register(YCPromoFilterCell.self, forCellWithReuseIdentifier: cellId)
        
        promoView.actionButtonCallback = { [weak self] in
            self?.delegate?.actionButtonPressed()
            self?.hideConteinerView()
        }
        
        promoView.ressetButtonCallback = { [weak self] in
            self?.delegate?.resetButtonPressed()
            self?.promoView.collectionView.reloadData()
            //self?.hideConteinerView()
        }
    }
    
    //MARK: - Actions
    
    private func reloadData() {
        promoView.collectionView.reloadData()
        promoView.updateCollectionViewHeight()
        let overMaxHeightValue = setConteinerViewHeight(with: promoView.getSumHeight(), animated: false)
        if overMaxHeightValue > 0 {
            promoView.collectionViewHeight -= overMaxHeightValue
        }
    }

}

extension YCActionSheetPromoFilterVC: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.getItems().count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! YCPromoFilterCell
        cell.tagButton.selectedColor = tagButtonSelectedColor
        cell.tagButton.unselectedColor = tagButtonUnselectedColor
        let item = delegate?.getItems()[indexPath.row] ?? ""
        cell.setTagButtonTitle(item)
        if let selectedItems = delegate?.getSelectedItems() {
            cell.setTagButtonSelected(selectedItems.contains(indexPath.row), animated: false)
        } else {
            cell.setTagButtonSelected(false, animated: false)
        }
        cell.callback = { [weak self] isSelected in
            self?.delegate.map({ isSelected ? $0.didSelectItem(at: indexPath) : $0.didDeselectItem(at: indexPath) })
        }
        cell.tagButton.setNeedsDisplay() // it's for many rows, when cell reuse, we will need to redraw button
        return cell
    }
    
}
