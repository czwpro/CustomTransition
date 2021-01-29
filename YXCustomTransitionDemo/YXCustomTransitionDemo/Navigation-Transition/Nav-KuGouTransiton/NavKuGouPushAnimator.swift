//
//  NavKuGouPushAnimator.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavKuGouPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        
        
        // 动画 仿射变换动画
        let centerX = toView!.width * 0.5
        let centerY = toView!.height * 0.5
        let x = toView!.width * 0.5
        let y = toView!.height * 1.8
        // 角度与弧度的转换：Double.pi = 180°，45° 对应的弧度 = 45.0 / 180.0 * Double.pi
        let angle: CGFloat = CGFloat(45.0 / 180.0 * Double.pi)
        
        // 起始位置：原始位置绕x,y旋转45º后的位置
        let trans = GetCGAffineTransformRotateAround(centerX: centerX, centerY: centerY, x: x, y: y, angle: angle)
        toView?.transform = trans
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            // 终止位置: 原始位置
            toView?.transform = CGAffineTransform.identity
        } completion: { _ in
            //设置transitionContext通知系统动画执行完毕
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        
    }
    
    /**
     仿射变换
     
     @param centerX     view的中心点X坐标
     @param centerY     view的中心点Y坐标
     @param x           旋转中心x坐标
     @param y           旋转中心y坐标
     @param angle       旋转的角度
     @return            CGAffineTransform对象
     */
    func GetCGAffineTransformRotateAround(centerX: CGFloat, centerY: CGFloat, x: CGFloat, y: CGFloat, angle: CGFloat) -> CGAffineTransform {
        let l = y - centerY
        let h = l * sin(angle)
        let b = l * cos(angle)
        let a = l - b
        let x1 = h
        let y1 = a

        let trans = CGAffineTransform(translationX: x1, y: y1).rotated(by: angle)
        return trans
    }
    
}

