//
//  PopAnimator.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/30.
//

import Cocoa

class PopAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    // 出现动画
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let fromVC = fromViewController as! PopoverViewController
        let toVC = viewController
        toVC.view.wantsLayer = true
        toVC.view.alphaValue = 0
        toVC.view.frame = CGRect(x: 0, y: -PopViewHeight * 0.9, width: PopViewWidth, height: PopViewHeight * 0.9)
        fromVC.addButton.isEnabled = false
        fromVC.view.addSubview(toVC.view)
        
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.5
            toVC.view.animator().alphaValue = 1.0
            toVC.view.animator().frame = CGRect(x: 0, y: -PopViewHeight * 0.03, width: PopViewWidth, height: PopViewHeight * 0.9)
        }
        
        
    }
    
    // 消失动画
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let toVC = viewController
        let fromVC = fromViewController as! PopoverViewController
        toVC.view.wantsLayer = true
        
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.5
            toVC.view.animator().alphaValue = 0
            toVC.view.animator().frame = CGRect(x: 0, y: -PopViewHeight * 0.9, width: PopViewWidth, height: PopViewHeight * 0.9)
        } completionHandler: {
            toVC.view.removeFromSuperview()
            fromVC.addButton.isEnabled = true
        }

    }
}
















