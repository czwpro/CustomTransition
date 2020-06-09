//
//  NavBaseViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavBaseFirstViewController: UIViewController {

    let customAnimator = NavBaseCustomAnimator()
    
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
        view.backgroundColor = UIColor.backgroundColor()
        view.layer.masksToBounds = true
        
        view.addSubview(imageView)
    }

    @objc func pushSecond() {
        navigationController?.delegate = self
        let secondController = NavBaseSecondViewController()
        navigationController?.pushViewController(secondController, animated: true)
    }
}

extension NavBaseFirstViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return customAnimator
        } else if operation == .pop {
            return customAnimator
        }
        return nil
    }

    
}
