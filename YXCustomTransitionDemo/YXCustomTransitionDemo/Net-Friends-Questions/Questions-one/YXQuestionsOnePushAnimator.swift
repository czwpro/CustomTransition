//
//  YXQuestionsOnePushAnimator.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXQuestionsOnePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionImgView: UIImageView?
    
    //转场前图片的frame
    var transitionBeforeImgFrame: CGRect = CGRect.zero
    
    //转场后图片的frame
    var transitionAfterImgFrame: CGRect = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
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
        toView?.alpha = 0;
        
        // 过度的图片
        let transitionImgView = UIImageView(image: self.transitionImgView!.image)
        transitionImgView.frame = transitionBeforeImgFrame
        transitionContext.containerView.addSubview(transitionImgView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
            
            transitionImgView.frame = self.transitionAfterImgFrame
            toView?.alpha = 1;
            
        }) { _ in
            
            transitionImgView .removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
    
}
