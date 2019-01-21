//
//  YCSelectFilialCell.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/14/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

class YCSelectFilialCell: UITableViewCell {
    
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     imgView.heightAnchor.constraint(equalToConstant: 20),
                                     imgView.widthAnchor.constraint(equalToConstant: 20)])
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
                                     titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)])
        
        selectionStyle = .none
    }
    
}
