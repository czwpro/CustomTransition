//
//  YXNavKuGouTransitionViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavKuGouTransitionViewController: UIViewController {
    
    var animatedTransition: YXNavKuGouAnimationTransition = YXNavKuGouAnimationTransition()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "kugoou")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "KuGou"
        view.backgroundColor = UIColor.backgroundColor()
        view.addSubview(imageView)
    }
    
    @objc func pushSecond() {
        // 1.设置代理
        navigationController?.delegate = animatedTransition
        
        // 2.push跳转
        let controller = YXNavKuGouSecondViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

}
