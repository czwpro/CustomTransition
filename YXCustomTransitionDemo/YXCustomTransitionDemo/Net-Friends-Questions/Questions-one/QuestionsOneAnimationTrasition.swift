//
//  QuestionsOneAnimationTrasition.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class QuestionsOneAnimationTrasition: NSObject, UINavigationControllerDelegate {

    private let customPush = QuestionsOnePushAnimator()
    private let customPop = QuestionsOnePopAnimator()
    
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
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else if (operation == .pop) {
            return customPop
        }
        return nil
    }
}
