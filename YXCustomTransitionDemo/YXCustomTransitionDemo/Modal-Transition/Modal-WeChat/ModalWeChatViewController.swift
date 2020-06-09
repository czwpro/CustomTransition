//
//  ModalWeChatViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalWeChatViewController: UIViewController {

    var animatedTransition = ModalWeChatAnimationTransition()
    
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
        title = "WeChat"
        view.backgroundColor = UIColor.backgroundColor()
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = nil
    }
    
    @objc func pushSecond() {
        
        // 1.传入必要的3个参数
        animatedTransition.transitionImgView = imageView
        animatedTransition.transitionBeforeImgFrame = imageView.frame
        animatedTransition.transitionAfterImgFrame = backScreenImageViewRectWithImage(image: imageView.image!)
        
        let controller = ModalWeChatSecondViewController()
        
        controller.modalPresentationStyle = .fullScreen
        
        // 2.设置代理
        controller.transitioningDelegate = animatedTransition
        
        // 3.present
        self.present(controller, animated: true, completion: nil)
    }
    
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
