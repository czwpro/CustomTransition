//
//  CATransitionType.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2021/1/28.
//  Copyright © 2021 蔡志文. All rights reserved.
//

import UIKit

/*
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
extension CATransitionType {
    static let cube = CATransitionType(rawValue: "cube")
    static let pageCurl = CATransitionType(rawValue: "pageCurl")
    static let pageUnCurl = CATransitionType(rawValue: "pageUnCurl")
    static let rippleEffect = CATransitionType(rawValue: "rippleEffect")
    static let suckEffect = CATransitionType(rawValue: "suckEffect")
    static let oglFlip = CATransitionType(rawValue: "oglFlip")
    static let cameraIrisHollowClose = CATransitionType(rawValue: "cameraIrisHollowClose")
    static let cameraIrisHollowOpen = CATransitionType(rawValue: "cameraIrisHollowOpen")
}

