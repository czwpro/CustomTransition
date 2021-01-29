//
//  NavWeChatInteractivePopAnimator.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavWeChatInteractivePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionImgView: UIImageView?
    var transitionBeforeImgFrame = CGRect.zero
    var transitionAfterImgFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        
        // 图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象 [可以换种颜色看看效果])
        let imgBgWhiteView = UIView(frame: transitionBeforeImgFrame)
        imgBgWhiteView.backgroundColor = UIColor.background
        containerView.addSubview(imgBgWhiteView)
        
        // 有渐变的黑色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 1
        containerView.addSubview(bgView)
        
        //过渡的图片
        let transitionImgView = UIImageView(image: self.transitionImgView?.image)
        transitionImgView.frame = transitionAfterImgFrame
        transitionContext.containerView.addSubview(transitionImgView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveLinear) {
            transitionImgView.frame = self.transitionBeforeImgFrame
            bgView.alpha = 0
        } completion: { _ in
            imgBgWhiteView.removeFromSuperview()
            bgView.removeFromSuperview()
            transitionImgView.removeFromSuperview()
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    deinit {
        print("deinit: \(type(of: self))")
    }
}
