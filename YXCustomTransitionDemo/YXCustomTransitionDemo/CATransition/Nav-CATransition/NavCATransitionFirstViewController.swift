//
//  NavCATransitionFirstViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/13.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class NavCATransitionFirstViewController: UIViewController {

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

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidAppear(animated)
    }
    
    @objc func pushSecond() {
        let controller = NavCATransitionSecondViewController()
        navigationController?.view.layer.add(pushAnimation(), forKey: nil)
        // 记得这里的 animated 要设为 false，不然会重复
        navigationController?.pushViewController(controller, animated: false)
    }

    func pushAnimation() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
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
        transition.type = convertToCATransitionType("cube")
        
        // 转场方向
        transition.subtype = CATransitionSubtype.fromRight
        
        return transition
    }

}

fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}
