//
//  YXNavCATransitionFirstViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/13.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXNavCATransitionFirstViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.center = self.view.center
        imageView.image = UIImage(named: "CATransition")
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        title = "Nav-CATransition"
        view.backgroundColor = UIColor.backgroundColor()
        view.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = nil
    }
    
    @objc func pushSecond() {
        let controller = YXNavCATransitionSecondViewController()
        navigationController?.view.layer.add(pushAnimation(), forKey: nil)
        navigationController?.pushViewController(controller, animated: true)
    }

    func pushAnimation() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        /* type
         私有API
         cube                   立方体效果
         pageCurl               向上翻一页
         pageUnCurl             向下翻一页
         rippleEffect           水滴波动效果
         suckEffect             变成小布块飞走的感觉
         oglFlip                上下翻转
         cameraIrisHollowClose  相机镜头关闭效果
         cameraIrisHollowOpen   相机镜头打开效果
         */
        
        //下面四个是系统共有的API
        //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.type = "cube"
        
        // 转场方向
        transition.subtype = kCATransitionFromRight
        
        return transition
    }

}
