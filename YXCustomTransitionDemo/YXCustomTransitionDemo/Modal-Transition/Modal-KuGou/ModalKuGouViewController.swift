//
//  ModalKuGouViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalKuGouViewController: UIViewController {

    lazy var animatedTransition = ModalKuGouAnimationTransition()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "kugoou")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "KuGou"
        view.backgroundColor = UIColor.background
        view.layer.masksToBounds = true
    }
    
    @objc func presentSecond() {
        let controller = ModalKuGouSecondViewController()
        
        controller.modalPresentationStyle = .fullScreen
        
        // 1.设置代理
        controller.transitioningDelegate = animatedTransition
        
        // 2.跳转
        self.present(controller, animated: true, completion: nil)
    }
}
