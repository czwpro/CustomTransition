//
//  YXModalBaseViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXModalBaseViewController: UIViewController {

    lazy var customAnimator = YXNavBaseCustomAnimator()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "Base")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "Base"
        view.backgroundColor = UIColor.backgroundColor()
        view.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = nil
    }
    
    @objc func presentSecond() {
        let controller = YXModalBaseSecondViewController()
       
        // 1.设置代理
        controller.transitioningDelegate = self
        
        // 2.跳转
        self.present(controller, animated: true, completion: nil)
    }
}

extension YXModalBaseViewController: UIViewControllerTransitioningDelegate {
    
    // present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
    
    // dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
    
}
