//
//  QuestionsOnePopAnimator.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class QuestionsOnePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionImgView: UIImageView?
    
    //转场前图片的frame
    var transitionBeforeImgFrame: CGRect = CGRect.zero
    
    //转场后图片的frame
    var transitionAfterImgFrame: CGRect = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        toView?.alpha = 0;
        
        //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
        let imgBgWhiteView = UIView(frame: transitionBeforeImgFrame)
        imgBgWhiteView.backgroundColor = UIColor.background
        containerView.addSubview(imgBgWhiteView)
        
        //有渐变的白色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.white
        bgView.alpha = 1
        containerView.addSubview(bgView)
        
        
        // 过度的图片
        let transitionImgView = UIImageView(image: self.transitionImgView!.image)
        transitionImgView.frame = transitionAfterImgFrame
        transitionContext.containerView.addSubview(transitionImgView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveLinear) {
            
            transitionImgView.frame = self.transitionBeforeImgFrame
            toView?.alpha = 1;
            
        } completion: { _ in
            imgBgWhiteView.removeFromSuperview()
            bgView.removeFromSuperview()
            transitionImgView .removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
