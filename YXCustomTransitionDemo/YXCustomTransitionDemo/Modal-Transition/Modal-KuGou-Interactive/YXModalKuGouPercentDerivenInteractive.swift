//
//  YXModalKuGouPercentDerivenInteractive.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalKuGouPercentDerivenInteractive: UIPercentDrivenInteractiveTransition {

    var gestureRecognizer: UIPanGestureRecognizer
    
    
    init(gestureRecognizer: UIPanGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
    }
    
    deinit {
        gestureRecognizer.removeTarget(self, action: #selector(gestureRecognizeDidUpdate(gesture:)))
    }
    
    @objc func gestureRecognizeDidUpdate(gesture: UIPanGestureRecognizer) {
        let scale = 1 - percentForGesture(gesture: gesture)
        print("interactive: \(scale)")
        
        switch gesture.state {
        case .began:
            //没用
            break;
        case .changed:
            update(scale)
        case .ended:
            scale < 0.2 ? cancel() : finish()
        default:
            cancel()
        }
    }
    
    func percentForGesture(gesture: UIPanGestureRecognizer) -> CGFloat {
        
        let translation = gesture.translation(in: gesture.view!)
        
        var scale = 1 - abs(translation.x / screenWidth)
        scale = scale < 0 ? 0 : scale
        
        return scale
    }
}
