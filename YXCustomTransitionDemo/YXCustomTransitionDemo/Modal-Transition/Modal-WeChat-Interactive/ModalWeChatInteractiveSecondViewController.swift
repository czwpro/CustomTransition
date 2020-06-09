//
//  ModalWeChatInteractiveSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalWeChatInteractiveSecondViewController: UIViewController {

    var beforeImageViewFrame: CGRect?
    
    private let animatedTransition = ModalWeChatInteractiveAnimatedTransition()
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "Wechat-Interactive.jpeg")
        let size = backImageSize(image: image!)
        let imageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - size.height) * 0.5, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private var transitionImgViewCenter: CGPoint?
    
    let navView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navigationBarAndStatusBarHeight))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: statusBarHeight, width: 44, height: 44))
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "WeChatSecond"
        view.backgroundColor = UIColor.black
        transitionImgViewCenter = imageView.center
        
        view.addSubview(navView)
        view.addSubview(backButton)
        
        let interactiveTransitionRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(gestureRecognizer:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
    }
    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func interactiveTransitionRecognizerAction(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
        
        var scale = 1 - abs(translation.y / screenHeight)
        scale = scale < 0 ? 0 : scale
        
        print("second = \(scale)")
        switch gestureRecognizer.state {
        case .possible: break
        case .began:
            //1. 设置代理
            transitioningDelegate = animatedTransition
            
            //2. 传值
            animatedTransition.gestureRecognizer = gestureRecognizer
            
            //3. present
            self.dismiss(animated: true, completion: nil)
            
        case .changed:
            
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
            
            animatedTransition.gestureRecognizer = nil
        
        @unknown default: break
            
        }
        
        
    }
    
    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }

}
