//
//  YXPictureBrowsePopAnimator.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXPictureBrowsePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionParameter: YXPictureBrowseTransitionParameter?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let transitionParameter = transitionParameter else { return }
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        
        // change Frame
        let fromFrame = transitionParameter.secondVCImgFrame
        let toFrame = transitionParameter.firstVCImgFrames[transitionParameter.transitionImgIndex].cgRectValue
        
        
        //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
        let imgBgWhiteView = UIView(frame: transitionParameter.firstVCImgFrames[transitionParameter.transitionImgIndex].cgRectValue)
        imgBgWhiteView.backgroundColor = UIColor.white
        containerView.addSubview(imgBgWhiteView)
        
        //有渐变的黑色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 1
        containerView.addSubview(bgView)
        
        // 过度的图片
        let transitionImgView = UIImageView(image: transitionParameter.transitionImage)
        transitionImgView.clipsToBounds = true
        transitionImgView.frame = fromFrame
        transitionContext.containerView.addSubview(transitionImgView)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
            
            //避免frame数值都为零的处理
            var imageFrame = toFrame
            if imageFrame.size.width == 0 && imageFrame.size.height == 0 {
                let defaultWidth: CGFloat = 5
                imageFrame = CGRect(x: (yx_screenWidth - defaultWidth) * 0.5, y: (yx_screenHeight - defaultWidth) * 0.5, width: defaultWidth, height: defaultWidth)
            }
            transitionImgView.frame = imageFrame
            bgView.alpha = 0
            
        }) { _ in
            bgView.removeFromSuperview()
            imgBgWhiteView.removeFromSuperview()
            transitionImgView .removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
}
