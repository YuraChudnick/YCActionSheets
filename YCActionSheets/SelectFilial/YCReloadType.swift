//
//  YCReloadType.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/16/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

public enum YCReloadType {
    case add
    case delete(indexPath: IndexPath)
    case all
}
