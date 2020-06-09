//
//  ModalWeChatAnimationTransition.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalWeChatAnimationTransition: NSObject, UIViewControllerTransitioningDelegate {
    
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
    
    private let customPush = NavWeChatPushAnimator()
    private let customPop = NavWeChatPopAnimator()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
        return customPush
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
        return customPop
    }
}
