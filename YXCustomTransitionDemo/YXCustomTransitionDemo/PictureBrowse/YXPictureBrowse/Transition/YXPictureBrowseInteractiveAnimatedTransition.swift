//
//  YXPictureBrowseInteractiveAnimatedTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXPictureBrowseInteractiveAnimatedTransition: NSObject, UIViewControllerTransitioningDelegate {

    private let customPush = YXPictureBrowsePushAnimator()
    private let customPop = YXPictureBrowsePopAnimator()
    
    
    var transitionParameter: YXPictureBrowseTransitionParameter? {
        didSet {
            customPush.transitionParameter = transitionParameter
            customPop.transitionParameter = transitionParameter
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPush
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPop
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil  //push时不加手势交互
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("00000000000000000000000000000000")
        guard let transitionParameter = transitionParameter, let _ = transitionParameter.gestureRecognizer else { return nil }
        print("gestimgframe: \(transitionParameter.currentPanGestImgFrame)")
        let percentIntractive = YXPictureBrowsePercentDrivenInteractive(transitionParameter: transitionParameter)
        return percentIntractive
    }
}
