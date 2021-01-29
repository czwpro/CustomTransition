//
//  QuestionTwoPushAnimator.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class QuestionTwoPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    //转场前图片的frame
    var transitionBeforeImgFrame: CGRect = CGRect.zero
    
    var transitionImg: UIImage?
    
    var flipImg: UIImage?
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // FromVC
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        containerView.addSubview(fromView!)
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        toView?.isHidden = true
        
        //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
        let imgBgWhiteView = UIView(frame: transitionBeforeImgFrame)
        imgBgWhiteView.backgroundColor = UIColor.background
        containerView.addSubview(imgBgWhiteView)
        
        //有渐变的白色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.white
        bgView.alpha = 0
        containerView.addSubview(bgView)
        
        
        // 过度的图片
        let transitionImgView = UIImageView(image: transitionImg)
        transitionImgView.frame = transitionBeforeImgFrame
        transitionContext.containerView.addSubview(transitionImgView)
        
        let flipView = UIImageView(image: flipImg)
        flipView.frame = transitionBeforeImgFrame
        transitionContext.containerView.addSubview(flipView)
        flipView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        flipView.layer.transform = getTransForm3D(with: 0)
        flipView.frame = self.transitionBeforeImgFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            transitionImgView.frame = transitionContext.containerView.bounds
            flipView.frame = CGRect(x: 0, y: 0, width: transitionContext.containerView.frame.size.width * 0.7, height: transitionContext.containerView.frame.size.height)
            flipView.layer.transform = self.getTransForm3D(with: CGFloat(-Double.pi / 2 - Double.pi / 8))
            bgView.alpha = 1
        } completion: { _ in
            toView?.isHidden = false
            
            imgBgWhiteView.removeFromSuperview()
            bgView.removeFromSuperview()
            transitionImgView .removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
    func getTransForm3D(with angle: CGFloat) -> CATransform3D {
        //获取一个标准默认的CATransform3D仿射变换矩阵
        var transform = CATransform3DIdentity
        transform.m34 = 4.5 / -2000 // 透视效果
        //获取旋转angle角度后的rotation矩阵。
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
}
