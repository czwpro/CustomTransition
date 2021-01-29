//
//  NavBaseInteractiveFirstViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavBaseInteractiveFirstViewController: UIViewController {

    let animatedTransition = NavBaseInteractiveAnimatedTransition()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "Base")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Base"
        view.backgroundColor = UIColor.background
        view.layer.masksToBounds = true
        
        view.addSubview(imageView)
    }
    
    @objc func pushSecond() {
        //1. 设置代理
        navigationController?.delegate = animatedTransition
        
        //2.push跳转
        let secondController = NavBaseInteractiveSecondViewController()
        navigationController?.pushViewController(secondController, animated: true)
    }

}
