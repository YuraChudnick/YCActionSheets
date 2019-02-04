//
//  DismissAnimationController.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 2/4/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration: TimeInterval
    
    init(animationDuration: TimeInterval = 0.15) {
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
    
        var overflowView: UIView?
        for v in conteinerView.subviews {
            if v.tag == -1 {
                overflowView = v
                break
            }
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            overflowView?.alpha = 0
        }) { _ in
            overflowView?.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
