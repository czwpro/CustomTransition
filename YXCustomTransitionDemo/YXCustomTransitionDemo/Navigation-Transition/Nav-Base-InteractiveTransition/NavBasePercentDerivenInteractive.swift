//
//  NavBasePercentDerivenInteractive.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavBasePercentDerivenInteractive: UIPercentDrivenInteractiveTransition {

    var gestureRecognizer: UIPanGestureRecognizer
    
    init(gestureRecognizer: UIPanGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gestureRecognizer:)))
    }
    
    //实现 UIViewControllerInteractiveTransitioning 协议的方法（必须实现）
    //开始交互转场
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        //相当于走到 Animator 中的代理方法去了，那里实现了具体的动画
        super.startInteractiveTransition(transitionContext)
    }
    
    deinit {
        gestureRecognizer.removeTarget(self, action: #selector(gestureRecognizeDidUpdate(gestureRecognizer:)))
    }
    
    @objc func gestureRecognizeDidUpdate(gestureRecognizer: UIPanGestureRecognizer) {
        
        let scale = 1 - percentForGesture(gesture: gestureRecognizer)
        
        switch gestureRecognizer.state {
        case .began:
            // 无用
            break
        case .changed:
            //更新百分比
            update(scale)
        case .ended:
            if scale < 0.3 {
                //取消转场
                cancel()
            } else {
                //完成转场
                finish()
            }
        default:
            cancel()
        }
    }
    
    func percentForGesture(gesture: UIPanGestureRecognizer) -> CGFloat {
        
        let translation = gesture.translation(in: gesture.view!)
        
        var scale = 1 - abs(translation.x / screenWidth)
        scale = scale < 0 ? 0 : scale
        
        return CGFloat(scale)
    }
}
