//
//  ModalWeChatPercentDrivenInteractive.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalWeChatPercentDrivenInteractive: UIPercentDrivenInteractiveTransition {

    /** 当前图片 */
    var currentImageView: UIImageView?
    /** //图片的frame */
    var beforeImageViewFrame = CGRect.zero
    /** 当前图片的frame */
    var currentImageViewFrame = CGRect.zero
    
    private let gestureRecognizer: UIPanGestureRecognizer?
    
//    private var bgView: UIView?
//    private var fromView: UIView?
    
    private var transitionContext: UIViewControllerContextTransitioning?
    private var beforeImgWhiteView: UIView?
    private var blackBgView: UIView?
    
    private var isFirst = false
    
    init(gestureRecognizer: UIPanGestureRecognizer?) {
        self.gestureRecognizer = gestureRecognizer
        isFirst = true
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
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        //注释掉，这样调用会是线性的动画，体验不好，所以在本类里自定义交互式的动画
        //        super.startInteractiveTransition(transitionContext)
    }
    
    @objc func gestureRecognizeDidUpdate(gesture: UIPanGestureRecognizer) {
        let scale = percentForGesture(gesture: gesture)
        print("interactive: \(scale)")
        
        if isFirst {
            beginInterPercent()
            isFirst = false
        }
        
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
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
            transitionImgView.frame = self.beforeImageViewFrame
            bgView.alpha = 0
        }) { _ in
            self.blackBgView?.removeFromSuperview()
            self.beforeImgWhiteView?.removeFromSuperview()
            self.blackBgView = nil
            self.beforeImgWhiteView = nil
            
            bgView.removeFromSuperview()
            imgBgWhiteView.removeFromSuperview()
            transitionImgView.removeFromSuperview()
            
            self.transitionContext?.finishInteractiveTransition()
            let cancel = self.transitionContext!.transitionWasCancelled
            self.transitionContext?.completeTransition(!cancel)
            
        }
    }
}
