//
//  YXQuestionTwoAnimationTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXQuestionTwoAnimationTransition: NSObject, UINavigationControllerDelegate {

    /** 转场过渡的图片 */
    var transitionImg: UIImage? {
        didSet {
            customPush.transitionImg = transitionImg;
            customPop.transitionImg = transitionImg;
        }
    }
    
    /** 转场过渡的图片 */
    var flipImg: UIImage? {
        didSet {
            customPush.flipImg = flipImg;
            customPop.flipImg = flipImg;
        }
    }
    
    /** 转场前的图片frame */
    var transitionBeforeImgFrame = CGRect.zero {
        didSet {
            customPop.transitionBeforeImgFrame = transitionBeforeImgFrame;
            customPush.transitionBeforeImgFrame = transitionBeforeImgFrame;
        }
    }
    
    private let customPush = YXQuestionTwoPushAnimator()
    private let customPop = YXQuestionTwoPopAnimator()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else if (operation == .pop) {
            return customPop
        }
        return nil
    }
}
