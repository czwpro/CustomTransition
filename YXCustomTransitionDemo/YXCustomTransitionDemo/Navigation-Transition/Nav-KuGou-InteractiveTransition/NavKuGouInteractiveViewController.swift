//
//  NavKuGouInteractiveViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavKuGouInteractiveViewController: UIViewController {

    private let animatedTransition = NavKuGouInteractiveAnimatedTransition()
   
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
        title = "KuGou-Interactive"
        view.backgroundColor = UIColor.background
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = nil
    }
    
    @objc func pushSecond() {
        // 1.设置代理
        navigationController?.delegate = animatedTransition
        
        // 2.push跳转
        let controller = NavKuGouInteractiveSecondViewController()
        navigationController?.pushViewController(controller, animated: true)
    }


}
