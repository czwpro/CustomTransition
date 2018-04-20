//
//  YXNavWeChatAnimationTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavWeChatAnimationTransition: NSObject, UINavigationControllerDelegate {
    
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
        }
    }
    
    /** 转场后的图片frame */
    var transitionAfterImgFrame = CGRect.zero {
        didSet {
            customPush.transitionAfterImgFrame = transitionAfterImgFrame
            customPop.transitionAfterImgFrame = transitionAfterImgFrame
        }
    }
 
    private let customPush = YXNavWeChatPushAnimator()
    private let customPop = YXNavWeChatPopAnimator()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else if operation == .pop {
            return customPop
        }
        return nil
    }
}
