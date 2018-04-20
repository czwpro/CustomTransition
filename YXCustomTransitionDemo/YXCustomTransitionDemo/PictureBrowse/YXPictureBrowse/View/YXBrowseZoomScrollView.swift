//
//  YXBrowseZoomScrollView.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXBrowseZoomScrollView: UIScrollView {

    private var isSingleTap = false
    
    let zoomImageView: UIImageView = {
        let zoomImageView = UIImageView()
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.contentMode = .scaleAspectFit
        zoomImageView.clipsToBounds = true
        return zoomImageView
    }()
    
    var tapBlock: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        minimumZoomScale = 1.0
        maximumZoomScale = 3.0
        addSubview(zoomImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        guard let t = touch else { return }
        if t.tapCount == 1 {
            perform(#selector(singleTapClick), with: nil, afterDelay: 0.2)
        } else if touch?.tapCount == 2 {
            NSObject .cancelPreviousPerformRequests(withTarget: self)
            // 防止先执行单击手势后还执行下面双击手势动画异常问题
            if !isSingleTap {
                let touchPoint = t.location(in: zoomImageView)
                zoomDoubleTapWithPoint(touchPoint: touchPoint)
            }
        }
    }
    
    @objc func singleTapClick() {
        isSingleTap = true
        if let tapBlock = tapBlock {
            tapBlock()
        }
    }
    
    func zoomDoubleTapWithPoint(touchPoint: CGPoint) {
        if zoomScale > minimumZoomScale {
            setZoomScale(minimumZoomScale, animated: true)
        } else {
            let width = bounds.size.width / maximumZoomScale
            let height = bounds.size.height / maximumZoomScale
            zoom(to: CGRect(x: touchPoint.x - width / 2, y: touchPoint.y - height / 2, width: width, height: height), animated: true)
        }
    }
}

extension YXBrowseZoomScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 延中心点缩放
        var rect = zoomImageView.frame
        rect.origin.x = 0
        rect.origin.y = 0
        if rect.size.width < frame.size.width {
            rect.origin.x = floor((frame.size.width - rect.size.width) * 0.5)
        }
        if rect.size.height < frame.size.height {
            rect.origin.y = floor((frame.size.height - rect.size.height) * 0.5)
        }
        zoomImageView.frame = rect
    }
    
}
