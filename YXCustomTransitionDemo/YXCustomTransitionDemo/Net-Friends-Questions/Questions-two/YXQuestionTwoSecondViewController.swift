//
//  YXQuestionTwoSecondViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXQuestionTwoSecondViewController: UIViewController {
    
    private lazy var imgView: UIImageView = {
        let image = UIImage(named: "content")
        let imgView = UIImageView(image: image)
        imgView.frame = view.bounds
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "QuestionTwoSecond"
        view.backgroundColor = UIColor.black
        
        view.addSubview(imgView)
        
    }


}
