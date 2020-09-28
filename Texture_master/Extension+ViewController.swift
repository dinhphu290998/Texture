//
//  Extension+ViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/22/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(childViewController viewController: UIViewController, sourceView:UIView ) {
        addChild(viewController)
        viewController.view.frame = CGRect.init(origin: .zero, size: sourceView.frame.size)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        UIView.transition(with: sourceView, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            sourceView.addSubview(viewController.view)
        }, completion: { _ in
            
        })
    }
    
    func addWithAnimation(childViewController viewController: UIViewController, sourceView:UIView, fromRight: Bool = true) {
        addChild(viewController)
        viewController.view.frame = sourceView.bounds
        viewController.view.frame.origin.x = fromRight ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
        viewController.view.alpha = 0
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        sourceView.addSubview(viewController.view)
        
        UIView.animate(withDuration: 0.3) {
            viewController.view.frame.origin.x = 0
            viewController.view.alpha = 1
        }
    }
    
    func addInScrollView(childViewController viewController: UIViewController, scrollView:UIView, page : CGFloat ) {
        addChild(viewController)
        viewController.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width / page, height: scrollView.frame.size.height)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        UIView.transition(with: scrollView, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            scrollView.addSubview(viewController.view)
        }, completion: { _ in
            
        })
    }
    
    func remove(childViewController viewController: UIViewController) {
        viewController.willMove(toParent: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func removeWithAnimation(childViewController viewController: UIViewController, fromRight: Bool = true) {
        UIView.animate(withDuration: 0.3, animations: {
            viewController.view.frame.origin.x = fromRight ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
            viewController.view.alpha = 0
        }) { (_) in
            self.remove(childViewController: viewController)
        }
    }
    
    class func top(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return top(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return top(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return top(controller: presented)
        }
        return controller
    }
}

extension UIViewController {
    func parentViewController(ofClass: AnyClass) -> UIViewController? {
        guard let parent = self.parent else { return nil }
        
        if parent.isKind(of: ofClass) {
            return parent
        }
        
        return parent.parentViewController(ofClass: ofClass)
    }
    
    func backToViewController(ofClass: AnyClass) {
        guard let parent = self.parentViewController(ofClass: ofClass) else { return }
        
        parent.children.forEach({ childVC in
            parent.removeWithAnimation(childViewController: childVC)
        })
    }
}

extension UIViewController {
    func presentViewController(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = viewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        self.present(viewController, animated: flag, completion: completion)
    }
}

