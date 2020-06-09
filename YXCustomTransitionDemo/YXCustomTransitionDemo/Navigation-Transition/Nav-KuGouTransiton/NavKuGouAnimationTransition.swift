//
//  NavKuGouAnimationTransition.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavKuGouAnimationTransition: NSObject, UINavigationControllerDelegate {
    
    lazy var customPush: NavKuGouPushAnimator = NavKuGouPushAnimator()
    
    lazy var customPop: NavKuGouPopAnimator = NavKuGouPopAnimator()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else {
            return customPop
        }
    }
    
}
