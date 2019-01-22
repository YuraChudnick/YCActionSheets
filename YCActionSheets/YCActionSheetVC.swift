//
//  YCActionSheetVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetVC: UIViewController {
    
    // MARK: - Properties
    
    /// Background color.
    public var backColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    var standardSpacing: CGFloat = 60
    
    private let animationDuration: TimeInterval = 0.3
    private var isPresenting = false
    
    let conteinerView: UIView = UIView()
    private var conteinerViewHeight: CGFloat = 380
    private var conteinerViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Init
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupPresentationStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupPresentationStyle()
    }
    
    //MARK: - Setup presentation style
    
    fileprivate func setupPresentationStyle() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: - View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showConteinerView()
    }
    
    //MARK: Setup views
    
    fileprivate func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(conteinerView)
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        conteinerViewHeightConstraint = conteinerView.heightAnchor.constraint(equalToConstant: conteinerViewHeight)
        NSLayoutConstraint.activate([conteinerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     conteinerViewHeightConstraint])
    }
    
    //MARK: - Actions
    
    func showConteinerView() {
        conteinerView.center.y += conteinerViewHeight
        UIView.animate(withDuration: 0.25, delay: 0.05, options: [.curveEaseOut], animations: {
            self.conteinerView.center.y -= self.conteinerViewHeight
        }, completion: nil)
    }
    
    func hideConteinerView() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn], animations: {
            self.conteinerView.center.y += self.conteinerViewHeight
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.view {
                hideConteinerView()
            }
        }
    }
    
    public func setConteinerViewHeight(with value: CGFloat, animated: Bool = true) -> CGFloat {
        var result: CGFloat = 0
        let maxHeight = UIScreen.main.bounds.size.height - standardSpacing
        if value > maxHeight {
            conteinerViewHeight = maxHeight
            result = value - maxHeight
        } else {
            conteinerViewHeight = value
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.conteinerViewHeightConstraint.constant = self.conteinerViewHeight
                self.view.layoutIfNeeded()
            }
        } else {
            conteinerViewHeightConstraint.constant = conteinerViewHeight
        }
        return result
    }

}

extension YCActionSheetVC: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        
        return self
    }
    
}

extension YCActionSheetVC: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0 : animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = fromViewController.view
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewController.view
        
        if isPresenting {
            toView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            containerView.addSubview(toView!)
            
            transitionContext.completeTransition(true)
            presentView(toView!, presentingView: fromView!, animationDuration: animationDuration, completion: nil)
        } else {
            dismissView(fromView!, presentingView: toView!, animationDuration: animationDuration) { completed in
                if completed {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(completed)
            }
        }
    }
    
    private func presentView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.view.backgroundColor = self?.backColor
        }) { finished in
            completion?(finished)
        }
    }
    
    private func dismissView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.view.backgroundColor = UIColor.clear
        }) { _ in
            completion?(true)
        }
    }
    
}
