//
//  NavWeChatInteractiveSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavWeChatInteractiveSecondViewController: UIViewController {

    var beforeImageViewFrame: CGRect?
    
    private let animatedTransition = NavWeChatInteractiveAnimatedTransition()
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "Wechat-Interactive.jpeg")
        let size = backImageSize(image: image!)
        let imageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - size.height) * 0.5, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private var transitionImgViewCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "WeChatSecond"
        view.backgroundColor = UIColor.black
        transitionImgViewCenter = imageView.center
     
        let interactiveTransitionRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(gestureRecognizer:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
    }
    
    @objc func interactiveTransitionRecognizerAction(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)

        var scale = 1 - abs(translation.x / screenWidth)
        scale = scale < 0 ? 0 : scale
        scale = scale > 1 ? 1 : scale
        
        switch gestureRecognizer.state {
        case .possible: break
        case .began:
            //1. 设置代理
            navigationController?.delegate = animatedTransition
            
            //2. 传值
            animatedTransition.gestureRecognizer = gestureRecognizer
            
            //3. pop跳转
            navigationController?.popViewController(animated: true)
        case .changed:
            tabBarController?.tabBar.alpha = scale
            imageView.center = CGPoint(x: transitionImgViewCenter!.x + translation.x * scale, y: transitionImgViewCenter!.y + translation.y * scale)
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            animatedTransition.beforeImageViewFrame = beforeImageViewFrame!
        case .failed, .cancelled, .ended:
            if scale > 0.95 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageView.center = self.transitionImgViewCenter!
                    self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }) { _ in
                    self.imageView.transform = CGAffineTransform.identity
                }
            }
            animatedTransition.currentImageView = imageView
            animatedTransition.currentImageViewFrame = imageView.frame
            navigationController?.delegate = animatedTransition
         default: break
        }
        
    }
    
    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }

    deinit {
        print("deinit: \(type(of: self))")
    }
}
