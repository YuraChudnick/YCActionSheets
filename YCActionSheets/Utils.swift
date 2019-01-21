//
//  Utils.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/14/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import Foundation

struct Utils {
    
    static func imageNamed(_ name: String) -> UIImage {
        let cls = YCActionSheetSelectFilialVC.self
        var bundle = Bundle(for: cls)
        let traitCollection = UITraitCollection(displayScale: 3)
        
        if let resourceBundle = bundle.resourcePath.flatMap({ Bundle(path: $0 + "/YCActionSheets.bundle") }) {
            bundle = resourceBundle
        }
        
        guard let image = UIImage(named: name, in: bundle, compatibleWith: traitCollection) else {
            return UIImage()
        }
        
        return image
    }
    
    static func getSafeAreaBottomInset() -> CGFloat {
        var value: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            value += window?.safeAreaInsets.bottom ?? 0
        }
        return value
    }
    
}
