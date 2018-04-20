//
//  YXModalKuGouAnimationTransition.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalKuGouAnimationTransition: NSObject, UIViewControllerTransitioningDelegate {

    private let customPush = YXNavKuGouPushAnimator()
    private let customPop = YXNavKuGouPopAnimator()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
        return customPush
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
        return customPop
    }
}
