//
//  YXModalWeChatInteractiveViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalWeChatInteractiveViewController: UIViewController {

    private let animatedTransition = YXModalWeChatInteractiveAnimatedTransition()
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "wechat.jpg")
        var size = CGSize.zero
        size.height = 120
        size.width = size.height / image!.size.height * image!.size.width
        let imageView = UIImageView(frame: CGRect(x: 70, y: navigationBarAndStatusBarHeight + 20, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "WeChat-Interactive"
        view.backgroundColor = UIColor.backgroundColor()
        view.addSubview(imageView)
    }
    
    @objc func pushSecond() {
        
        // 1.传入必要的参数
        animatedTransition.transitionImgView = imageView
        animatedTransition.transitionBeforeImgFrame = imageView.frame
        animatedTransition.transitionAfterImgFrame = backScreenImageViewRectWithImage(image: imageView.image!)
        
        let controller = YXModalWeChatInteractiveSecondViewController()
        
        controller.modalPresentationStyle = .fullScreen
        
        // 2.设置代理
        controller.beforeImageViewFrame = imageView.frame
        controller.transitioningDelegate = animatedTransition
        
        // 3.push跳转
        self.present(controller, animated: true, completion: nil)
    }
    
    //返回imageView在window上全屏显示时的frame
    func backScreenImageViewRectWithImage(image: UIImage) -> CGRect {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height   // 等比例放大
        
        var imageY = (screenHeight - newSize.height) * 0.5
        if imageY < 0 {
            imageY = 0
        }
        
        let rect = CGRect(x: 0, y: imageY, width: newSize.width, height: newSize.height)
        return rect
        
    }
}
