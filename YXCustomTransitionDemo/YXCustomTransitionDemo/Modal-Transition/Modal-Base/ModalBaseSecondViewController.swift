//
//  ModalBaseSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/18.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class ModalBaseSecondViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let image = UIImage(named: "Base")
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
        view.backgroundColor = UIColor.backgroundColor()
        view.layer.masksToBounds = true
        
        view.addSubview(navView)
        view.addSubview(backButton)
    }

    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }

}
