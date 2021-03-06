//
//  NavWeChatSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/17.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavWeChatSecondViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "wechat.jpg")
        let size = backImageSize(image: image!)
        let imageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - size.height) * 0.5, width: size.width, height: size.height))
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "WeChatSecond"
        view.backgroundColor = UIColor.black
        view.layer.masksToBounds = true
    }

    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }
}
