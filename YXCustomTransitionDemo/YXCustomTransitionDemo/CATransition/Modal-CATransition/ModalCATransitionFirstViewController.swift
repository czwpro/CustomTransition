//
//  ModalCATransitionFirstViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalCATransitionFirstViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "CATransition")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "Modal-CATransition"
        view.backgroundColor = UIColor.background
        view.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = nil
    }
    
    @objc func presentSecond() {
        let controller = ModalCATransitionSecondViewController()
        controller.modalPresentationStyle = .fullScreen
        view.window?.layer.add(presentAnimation(), forKey: nil)
        self.present(controller, animated: false, completion: nil)  //记得这里的 animated 要设为 false，不然会重复
    }
    
    func presentAnimation() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        // 下面四个是系统开放的API
        // moveIn, push, reveal, fade
        transition.type = .push
        
        // 转场方向
        transition.subtype = .fromRight
        
        return transition
    }

}
