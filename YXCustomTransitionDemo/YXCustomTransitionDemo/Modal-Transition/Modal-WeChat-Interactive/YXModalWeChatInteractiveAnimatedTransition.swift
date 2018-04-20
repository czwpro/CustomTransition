//
//  YXModalWeChatInteractiveAnimatedTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalWeChatInteractiveAnimatedTransition: NSObject {

    private let customPush = YXNavWeChatInteractivePushAnimator()
    private let customPop = YXNavWeChatInteractivePopAnimator()
    
    private lazy var percentIntractive = YXModalWeChatPercentDrivenInteractive(gestureRecognizer: self.gestureRecognizer)
    
    var gestureRecognizer: UIPanGestureRecognizer?
    
    /** 当前图片 */
    var currentImageView: UIImageView? {
        didSet {
            percentIntractive.currentImageView = currentImageView
        }
    }
    
    /** 图片的frame */
    var beforeImageViewFrame = CGRect.zero {
        didSet {
            percentIntractive.beforeImageViewFrame = beforeImageViewFrame
        }
    }
    
    /** 当前图片的frame */
    var currentImageViewFrame = CGRect.zero {
        didSet {
            percentIntractive.currentImageViewFrame = currentImageViewFrame
        }
    }
    
    /** 转场过渡的图片 */
    var transitionImgView: UIImageView? {
        didSet {
            customPush.transitionImgView = transitionImgView
            customPop.transitionImgView = transitionImgView
        }
    }
    
    /** 转场前的图片frame */
    var transitionBeforeImgFrame = CGRect.zero {
        didSet {
            customPush.transitionBeforeImgFrame = transitionBeforeImgFrame
            customPop.transitionBeforeImgFrame = transitionBeforeImgFrame
            percentIntractive.beforeImageViewFrame = transitionBeforeImgFrame
        }
    }
    
    /** 转场后的图片frame */
    var transitionAfterImgFrame = CGRect.zero {
        didSet {
            customPush.transitionAfterImgFrame = transitionAfterImgFrame
            customPop.transitionAfterImgFrame = transitionAfterImgFrame
        }
    }
}

extension YXModalWeChatInteractiveAnimatedTransition: UIViewControllerTransitioningDelegate {
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
