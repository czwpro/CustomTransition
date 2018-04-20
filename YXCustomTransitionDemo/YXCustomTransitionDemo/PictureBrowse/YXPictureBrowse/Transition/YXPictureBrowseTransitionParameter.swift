//
//  YXPictureBrowseTransitionParameter.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

let yx_screenWidth = UIScreen.main.bounds.size.width
let yx_screenHeight = UIScreen.main.bounds.size.height

class YXPictureBrowseTransitionParameter {
    /*
     firstVC : 发起查看图片浏览器的界面
     secondVC: 图片浏览器界面
     */
    
    //************************** firstVC、secondVC 都需要传值
    ///转场过渡image
    var transitionImage: UIImage? {
        didSet {
            if let image = transitionImage {
                secondVCImgFrame = backScreenImageViewRectWithImage(image: image)
            }
        }
    }
    
    ///所浏览图片的下标
    var transitionImgIndex: Int = 0 {
        didSet {
            firstVCImgFrame = firstVCImgFrames[transitionImgIndex].cgRectValue
        }
    }
    
    
    //************************** 只需要firstVC 传值
    ///firstVC 图片的frame数组，记录所有图片view在第一个界面上相对于window的frame
    var firstVCImgFrames = [NSValue]()
    
    
    //************************** 只需要secondVC 传值
    ///滑动返回手势
    var gestureRecognizer: UIPanGestureRecognizer?
    
    ///当前滑动时，对应图片的frame
    var currentPanGestImgFrame = CGRect.zero {
        didSet {
            print("currentPanGestImgFrame: \(currentPanGestImgFrame)")
        }
    }
    
    
    //************************** 只读
    ///通过transitionImgIndex在内部计算出来在firstVC上所对应的图片frame
    var firstVCImgFrame = CGRect.zero
    
    ///通过transitionImage在内部计算出来在secondVC上所显示的图片frame
    var secondVCImgFrame = CGRect.zero
    
    //返回imageView在window上全屏显示时的frame
    func backScreenImageViewRectWithImage(image: UIImage) -> CGRect {
        
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = yx_screenWidth
        newSize.height = newSize.width / size.width * size.height
        
        var imageY = (yx_screenHeight - newSize.height) * 0.5
        if imageY < 0 {
            imageY = 0
        }
        let rect = CGRect(x: 0, y: imageY, width: newSize.width, height: newSize.height)
        return rect
    }

}
