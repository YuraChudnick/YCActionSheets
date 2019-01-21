//
//  YCActionSheetVC.swift
//  YCActionSheets
//
//  Created by Yurii Chudnovets on 1/11/19.
//  Copyright © 2019 Yurii Chudnovets. All rights reserved.
//

import UIKit

public class YCActionSheetVC: UIViewController {
    
    /// Background color.
    public var backColor: UIColor = UIColor.black.withAlphaComponent(0.5) {
        didSet {
            view.backgroundColor = backColor
        }
    }
    
    var standardSpacing: CGFloat = 60
    
    public let conteinerView: UIView = UIView()
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
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showConteinerView()
    }
    
    //MARK: Setup views
    
    fileprivate func setupViews() {
        view.backgroundColor = backColor
        
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
