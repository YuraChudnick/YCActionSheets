//
//  PresentAnimationController.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 2/4/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let overflowView: UIView = {
        let v = UIView()
        v.alpha = 0
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return v
    }()
    
    let animationDuration: TimeInterval
    
    init(animationDuration: TimeInterval = 0.25) {
        self.animationDuration = animationDuration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.viewController(forKey: .from),
        let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        let conteinerView = transitionContext.containerView
    
        conteinerView.addSubview(toVC.view)
        overflowView.tag = -1
        conteinerView.insertSubview(overflowView, at: 0)
        overflowView.fillSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.overflowView.alpha = 1
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
