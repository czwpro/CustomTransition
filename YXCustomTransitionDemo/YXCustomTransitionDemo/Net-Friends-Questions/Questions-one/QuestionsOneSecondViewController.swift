//
//  QuestionsOneSecondViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class QuestionsOneSecondViewController: UIViewController {

    var image: UIImage? {
        didSet {
            imgView.image = image
        }
    }
    var imgFrame = CGRect.zero {
        didSet {
            imgView.frame = imgFrame
        }
    }
    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "QuestionOneSecond"
        view.backgroundColor = UIColor.white
        
        view.addSubview(imgView)
        
        
        let labelY = imgView.frame.maxX
        let label = UILabel(frame: CGRect(x: 10, y: labelY, width: screenWidth - 20, height: screenHeight - labelY - 10))
        label.numberOfLines = 0
        label.text = "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"
        view.addSubview(label)
        
    }
}
