//
//  PictureBrowsePushAnimator.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class PictureBrowsePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionParameter: PictureBrowseTransitionParameter?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let transitionParameter = transitionParameter else { return }
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView

        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        toView?.isHidden = true
        containerView.addSubview(toView!)
        
        //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
        let imgBgWhiteView = UIView(frame: transitionParameter.firstVCImgFrames[transitionParameter.transitionImgIndex].cgRectValue)
        imgBgWhiteView.backgroundColor = UIColor.white
        containerView.addSubview(imgBgWhiteView)
        
        //有渐变的黑色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0
        containerView.addSubview(bgView)
        
        
        // 过度的图片
        let transitionImgView = UIImageView(image: transitionParameter.transitionImage)
        transitionImgView.frame = transitionParameter.firstVCImgFrames[transitionParameter.transitionImgIndex].cgRectValue
        transitionContext.containerView.addSubview(transitionImgView)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            transitionImgView.frame = transitionParameter.secondVCImgFrame
            bgView.alpha = 1
        }) { _ in
            toView?.isHidden = false
            
            imgBgWhiteView.removeFromSuperview()
            bgView.removeFromSuperview()
            transitionImgView .removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
