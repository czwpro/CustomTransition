//
//  YXNavBaseInteractiveAnimatedTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavBaseInteractiveAnimatedTransition: NSObject, UINavigationControllerDelegate {
    
    var gestureRecognizer: UIPanGestureRecognizer?
    
    lazy var customAnimator = YXNavBaseCustomAnimator()
    lazy var percentIntractive = YXNavBasePercentDerivenInteractive(gestureRecognizer: self.gestureRecognizer!)
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customAnimator
        } else if operation == .pop {
            return customAnimator
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let _ = gestureRecognizer else { return nil }
        
        //判断有手势，才去调用初始化
        return percentIntractive
    }
}
