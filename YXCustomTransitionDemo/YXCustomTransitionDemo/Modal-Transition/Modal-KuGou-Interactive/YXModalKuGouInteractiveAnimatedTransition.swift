//
//  YXModalKuGouInteractiveAnimatedTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalKuGouInteractiveAnimatedTransition: NSObject, UIViewControllerTransitioningDelegate {

    var gestureRecognizer: UIPanGestureRecognizer?
    
    private let customPush = YXNavKuGouPushAnimator()
    private let customPop = YXNavKuGouPopAnimator()
    private lazy var percentIntractive = YXModalKuGouPercentDerivenInteractive(gestureRecognizer: self.gestureRecognizer!)
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPush
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPop
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let _ = gestureRecognizer else { return nil }
        return percentIntractive
    }
    
}
