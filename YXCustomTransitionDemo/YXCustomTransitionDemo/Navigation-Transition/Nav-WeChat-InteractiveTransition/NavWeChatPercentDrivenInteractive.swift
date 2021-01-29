//
//  NavWeChatPercentDrivenInteractive.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavWeChatPercentDrivenInteractive: UIPercentDrivenInteractiveTransition {
    /** 当前图片 */
    var currentImageView: UIImageView?
    /** //图片的frame */
    var beforeImageViewFrame = CGRect.zero
    /** 当前图片的frame */
    var currentImageViewFrame = CGRect.zero
    
    private let customPush = NavWeChatInteractivePushAnimator()
    private let customPop = NavWeChatInteractivePopAnimator()

    private let gestureRecognizer: UIPanGestureRecognizer?
    
    private var bgView: UIView?
    private var fromView: UIView?
    // 避免循环引用
    private weak var transitionContext: UIViewControllerContextTransitioning?
    private var beforeImgWhiteView: UIView?
    private var blackBgView: UIView?
    
    init(gestureRecognizer: UIPanGestureRecognizer?) {
        self.gestureRecognizer = gestureRecognizer
        super.init()
        if let gesture = self.gestureRecognizer {
            gesture.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
        }
        
    }
    
    deinit {
        if let gestureRecognizer = self.gestureRecognizer {
            gestureRecognizer.removeTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customPush
        } else if operation == .pop {
            return customPop
        }
        return nil
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        //注释掉，这样调用会是线性的动画，体验不好，所以在本类里自定义交互式的动画
//        super.startInteractiveTransition(transitionContext)
        beginInterPercent()
    }
    
    @objc func gestureRecognizeDidUpdate(gesture: UIPanGestureRecognizer) {
        let scale = percentForGesture(gesture: gesture)

        switch gesture.state {
        case .began:
            //没用
            break;
        case .changed:
            update(scale)
            updateInterPercent(scale: scale)
        case .ended:
            if scale > 0.95 {
                cancel()
                interPercentCancel()
            } else {
                finish()
                interPercentFinish(scale: scale)
            }
        default:
            cancel()
            interPercentCancel()
        }
    }
    
    func percentForGesture(gesture: UIPanGestureRecognizer) -> CGFloat {
        
        let translation = gesture.translation(in: gesture.view!)
        
        var scale = 1 - abs(translation.y / screenHeight)
        scale = scale < 0 ? 0 : scale
        scale = scale > 1 ? 1 : scale
        
        return scale
    }
    
    func updateInterPercent(scale: CGFloat) {
        // 背景色变化
        blackBgView?.alpha = scale * scale * scale
    }
    
    func interPercentCancel() {
        // 取消
        
        //转场过渡的容器view
        let containerView = transitionContext?.containerView
        
        // FromVC
        let fromVC = transitionContext?.viewController(forKey: .from)
        let fromView = fromVC?.view
        fromView?.backgroundColor = UIColor.black
        containerView?.addSubview(fromView!)
        
        blackBgView?.removeFromSuperview()
        beforeImgWhiteView?.removeFromSuperview()
        blackBgView = nil
        beforeImgWhiteView = nil
        
        transitionContext?.completeTransition(!transitionContext!.transitionWasCancelled)
        
    }
    
    func beginInterPercent() {
        // 开始
        
        //转场过渡的容器view
        let containerView = transitionContext?.containerView
        
        // ToVC
        let toVC = transitionContext?.viewController(forKey: .to)
        let toView = toVC?.view
        containerView?.addSubview(toView!)
        
        //图片背景白色的空白view
        beforeImgWhiteView = UIView(frame: beforeImageViewFrame)
        beforeImgWhiteView?.backgroundColor = UIColor.white
        containerView?.addSubview(beforeImgWhiteView!)
        
        //有渐变的黑色背景
        blackBgView = UIView(frame: containerView!.bounds)
        blackBgView?.backgroundColor = UIColor.black
        containerView?.addSubview(blackBgView!)
        
        // FromVC
        let fromVC = transitionContext?.viewController(forKey: .from)
        let fromView = fromVC?.view
        fromView?.backgroundColor = UIColor.clear
        containerView?.addSubview(fromView!)
    }
    
    func interPercentFinish(scale: CGFloat) {
        // 完成
        //转场过渡的容器view
        let containerView = transitionContext?.containerView
        
        // ToVC
        let toVC = transitionContext?.viewController(forKey: .to)
        let toView = toVC?.view
        containerView?.addSubview(toView!)
        
        //图片背景白色的空白view
        let imgBgWhiteView = UIView(frame: beforeImageViewFrame)
        imgBgWhiteView.backgroundColor = UIColor.white
        containerView!.addSubview(imgBgWhiteView)
        
        //有渐变的黑色背景
        let bgView = UIView(frame: containerView!.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = scale
        containerView!.addSubview(bgView)
        
        // 过度的图片
        let transitionImgView = UIImageView(image: currentImageView?.image)
        transitionImgView.clipsToBounds = true
        transitionImgView.frame = currentImageViewFrame
        containerView!.addSubview(transitionImgView)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveLinear) {
            transitionImgView.frame = self.beforeImageViewFrame
            bgView.alpha = 0
        } completion: { _ in
            self.blackBgView?.removeFromSuperview()
            self.beforeImgWhiteView?.removeFromSuperview()
            self.blackBgView = nil
            self.beforeImgWhiteView = nil
            
            bgView.removeFromSuperview()
            imgBgWhiteView.removeFromSuperview()
            transitionImgView.removeFromSuperview()
            
            let cancel = self.transitionContext!.transitionWasCancelled
            self.transitionContext?.completeTransition(!cancel)
            
        }


    }
    
}





















