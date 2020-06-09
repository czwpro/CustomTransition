//
//  PictureBrowsePercentDrivenInteractive.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class PictureBrowsePercentDrivenInteractive: UIPercentDrivenInteractiveTransition {

    private let transitionParameter: PictureBrowseTransitionParameter
    private var transitionContext: UIViewControllerContextTransitioning?
    private var gestureRecognizer: UIPanGestureRecognizer?
    
    private var firstVCImgWhiteView: UIView?
    private var blackBgView: UIView?
    
    init(transitionParameter: PictureBrowseTransitionParameter) {
        print("----------------PercentDrivenInteractive init----------------")
        self.transitionParameter = transitionParameter
        gestureRecognizer = transitionParameter.gestureRecognizer
        super.init()
        guard let _ = gestureRecognizer else { return }
        gestureRecognizer?.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
    }
    
    deinit {
        gestureRecognizer?.removeTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        //注释掉，这样调用会是线性的动画，体验不好，所以在本类里自定义交互式的动画
        //        super.startInteractiveTransition(transitionContext)
        print("--------startInteractiveTransition--------")
        beginInterPercent()
    }
    
    @objc func gestureRecognizeDidUpdate(gesture: UIPanGestureRecognizer) {
        let scale = percentForGesture(gesture: gesture)
//        print("interactive: \(scale)")
        
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
        
        var scale = 1 - (translation.y / _screenHeight)
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
        guard let transitionContext = transitionContext else { return }
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // FromVC
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        fromView?.backgroundColor = UIColor.black
        containerView.addSubview(fromView!)
        
        blackBgView?.removeFromSuperview()
        firstVCImgWhiteView?.removeFromSuperview()
        blackBgView = nil
        firstVCImgWhiteView = nil
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
    }
    
    func beginInterPercent() {
        // 开始
        print("----------------开始----------------")
        guard let transitionContext = transitionContext else { return }
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        
        //图片背景白色的空白view
        firstVCImgWhiteView = UIView(frame: transitionParameter.firstVCImgFrame)
        firstVCImgWhiteView!.backgroundColor = UIColor.white
        containerView.addSubview(firstVCImgWhiteView!)
        
        //有渐变的黑色背景
        blackBgView = UIView(frame: containerView.bounds)
        blackBgView!.backgroundColor = UIColor.black
        containerView.addSubview(blackBgView!)
        
        // FromVC
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        fromView?.backgroundColor = UIColor.clear
        containerView.addSubview(fromView!)
    }
    
    func interPercentFinish(scale: CGFloat) {
        // 完成
        print("完成")
        guard let transitionContext = transitionContext else { return }
        
        //转场过渡的容器view
        let containerView = transitionContext.containerView
        
        // ToVC
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        containerView.addSubview(toView!)
        
        //图片背景白色的空白view
        let imgBgWhiteView = UIView(frame: transitionParameter.firstVCImgFrame)
        imgBgWhiteView.backgroundColor = UIColor.white
        containerView.addSubview(imgBgWhiteView)
        
        //有渐变的黑色背景
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = scale
        containerView.addSubview(bgView)
        
        // 过度的图片
        let transitionImgView = UIImageView(image: transitionParameter.transitionImage)
        transitionImgView.clipsToBounds = true
        transitionImgView.frame = transitionParameter.currentPanGestImgFrame
        containerView.addSubview(transitionImgView)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
            transitionImgView.frame = self.transitionParameter.firstVCImgFrame
            bgView.alpha = 0
        }) { _ in
            self.blackBgView?.removeFromSuperview()
            self.firstVCImgWhiteView?.removeFromSuperview()
            self.blackBgView = nil
            self.firstVCImgWhiteView = nil
            
            bgView.removeFromSuperview()
            imgBgWhiteView.removeFromSuperview()
            transitionImgView.removeFromSuperview()
            
            let cancel = self.transitionContext!.transitionWasCancelled
            self.transitionContext?.completeTransition(!cancel)
            
        }
    }
    
}
