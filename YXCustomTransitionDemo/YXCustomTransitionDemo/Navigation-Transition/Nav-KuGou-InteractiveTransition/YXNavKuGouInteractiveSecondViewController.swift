//
//  YXNavKuGouInteractiveSecondViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavKuGouInteractiveSecondViewController: UIViewController {

   
    let animatedTransition = YXNavKuGouInteractiveAnimatedTransition()
    var transitionImgViewCenter = CGPoint.zero
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "kugou-Interactive.jpeg")
        let size = backImageSize(image: image!)
        let imageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - size.height) * 0.5, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Kugou-Interactive-Second"
        view.backgroundColor = UIColor.black
        view.addSubview(imageView)
        
        transitionImgViewCenter = imageView.center
        
        let interactiveTransitionRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(gestureRecognizer:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
    }
    
    @objc func interactiveTransitionRecognizerAction(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
        
        var scale = 1 - fabs(translation.x / screenWidth)
        scale = scale < 0 ? 0 : scale
        scale = scale > 1 ? 1 : scale
        
        print("second = \(scale)")
        switch gestureRecognizer.state {
        case .possible: break
        case .began:
            //1. 设置代理
            navigationController?.delegate = animatedTransition
            
            //2. 传值
            animatedTransition.gestureRecognizer = gestureRecognizer
            
            //3. pop跳转
            navigationController?.popViewController(animated: true)
        case .changed: break
        case .failed, .cancelled, .ended:
            animatedTransition.gestureRecognizer = nil
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
