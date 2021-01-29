//
//  ModalCATransitionSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/16.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalCATransitionSecondViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let image = UIImage(named: "CATransition")
        let size = backImageSize(image: image!)
        let imageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - size.height) * 0.5, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
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
        title = "Second"
        view.backgroundColor = UIColor.background
        view.layer.masksToBounds = true
        
        view.addSubview(navView)
        view.addSubview(backButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super .viewDidDisappear(animated)
    }
    
    
    @objc func backButtonAction() {
        if let controllers = navigationController?.viewControllers, controllers.count > 1 {
            navigationController?.view.layer.add(popAnimation(), forKey: nil)
            navigationController?.popViewController(animated: false)
        } else {
            view.window?.layer.add(popAnimation(), forKey: nil)
            dismiss(animated: false, completion: nil)
        }
    }
    
    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }
    
    func popAnimation() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        // 下面四个是系统开放的API
        // moveIn, push, reveal, fade
        transition.type = .push
        
        // 转场方向
        transition.subtype = .fromLeft
        
        return transition
    }

}
