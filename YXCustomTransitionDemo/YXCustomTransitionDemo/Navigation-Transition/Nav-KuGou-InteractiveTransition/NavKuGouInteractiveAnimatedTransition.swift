//
//  NavKuGouInteractiveAnimatedTransition.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavKuGouInteractiveAnimatedTransition: NSObject, UINavigationControllerDelegate {
    
    private let customPush = NavKuGouPushAnimator()
    private let customPop  = NavKuGouPopAnimator()
    private lazy var percentIntractive = NavKuGouPercentDerivenInteractive(gesture: self.gestureRecognizer!)
    
    var gestureRecognizer: UIPanGestureRecognizer?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //此处的动画执行者和kugou非交互式中的执行者都是一样的,故此处不再重写，直接调用之前创建好的类
        if operation == .push {
            return customPush
        } else if operation == .pop {
            return customPop
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let _ = gestureRecognizer else { return nil }
        return percentIntractive
    }
    
}
