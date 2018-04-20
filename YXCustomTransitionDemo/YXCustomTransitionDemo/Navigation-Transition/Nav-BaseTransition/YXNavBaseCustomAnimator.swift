//
//  YXNavBaseCustomAnimator.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavBaseCustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    // 操作转场视图及视图所进行的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // FromVC
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
//       or let fromView = transitionContext.view(forKey: .from)
        fromView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)
        toView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        
        // 判断是Push，还是Pop操作
        var isPush = false
        if let toNavControllers = toVC?.navigationController?.viewControllers, let fromNavControllers = fromVC?.navigationController?.viewControllers, let _ = toNavControllers.index(of: toVC!), let _ = fromNavControllers.index(of: fromVC!) {
            isPush = true
        }
        
        if isPush {
            containerView.addSubview(fromView!)
            containerView.addSubview(toView!)
            toView?.frame = CGRect(x: screenWidth, y: screenHeight, width: screenWidth, height: screenHeight)
        } else {
            containerView.addSubview(toView!)
            containerView.addSubview(fromView!)
            fromView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }
        
        
        // 动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if isPush {
                toView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            } else {
                fromView?.frame = CGRect(x: screenWidth, y: screenHeight, width: screenWidth, height: screenHeight)
            }
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
