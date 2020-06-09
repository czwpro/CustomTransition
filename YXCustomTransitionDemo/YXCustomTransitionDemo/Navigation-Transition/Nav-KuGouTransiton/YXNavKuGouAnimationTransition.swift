//
//  YXNavKuGouAnimationTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavKuGouAnimationTransition: NSObject, UINavigationControllerDelegate {
    
    lazy var customPush: YXNavKuGouPushAnimator = YXNavKuGouPushAnimator()
    
    lazy var customPop: YXNavKuGouPopAnimator = YXNavKuGouPopAnimator()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else {
            return customPop
        }
    }
    
}
