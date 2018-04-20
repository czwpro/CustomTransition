//
//  YXQuestionTwoFirstViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXQuestionTwoFirstViewController: UIViewController {

    private lazy var imgView: UIImageView = {
        let image = UIImage(named: "flip")
        var size = CGSize.zero
        size.height = 120
        size.width = size.height / image!.size.height * image!.size.width
        
        let imgView = UIImageView(image: image)
        imgView.frame = CGRect(x: 50, y: 100, width: size.width, height: size.height)
        imgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        imgView.addGestureRecognizer(tap)
        return imgView
    }()
    
    private let animatedTransition = YXQuestionTwoAnimationTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "QuestionTwo"
        view.backgroundColor = UIColor.backgroundColor()
        
        view.addSubview(imgView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        navigationController?.delegate = nil
    }
    
    @objc func pushSecond() {
        //1. 设置代理
        navigationController?.delegate = animatedTransition;
        
        
        let contentImg = UIImage(named: "content")
        //2. 传入必要的3个参数
        animatedTransition.transitionImg = contentImg
        animatedTransition.transitionBeforeImgFrame = imgView.frame
        animatedTransition.flipImg = imgView.image
        
        //3.push跳转
        let secondController = YXQuestionTwoSecondViewController()
        navigationController?.pushViewController(secondController, animated: true)
    }

}
