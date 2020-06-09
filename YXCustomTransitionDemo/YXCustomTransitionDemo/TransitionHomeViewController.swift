//
//  TransitionHomeViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/13.
//  Copyright © 2018年 蔡志文. All rights reserved.
//  参考原作者github地址：https://github.com/yangli-dev/LYCustomTransition
//  处于联系使用 Swift 直译了下作者的OC版本
//

import UIKit

class TransitionHomeViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), style: .grouped)
        tableView.backgroundColor = UIColor.backgroundColor()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.rowHeight = 50
        tableView.sectionFooterHeight = 0.01
        return tableView
    }()
    
    let sectionTitleArray = ["CATransition", "导航 Navigation-Transition", "模态 Modal-Transition", "网友提问", "图片浏览器"]
    
    let cellTextArray = [
        ["Nav-CATransition",
         "Modal-CATransition"
        ],
        
        ["基础转场-非交互式",
         "仿酷狗转场-非交互式",
         "仿微信、苹果系统图片浏览转场-非交互式",
         "基础转场-交互式",
         "仿酷狗转场-交互式",
         "仿微信、苹果系统图片浏览转场-交互式"]
        ,
    
        ["基础转场",
         "仿酷狗转场-非交互式",
         "仿微信、苹果系统图片浏览转场-非交互式",
         "仿酷狗转场-交互式",
         "仿微信、苹果系统图片浏览转场-交互式"
        ],
    
        ["Question-one-仿淘宝有好货详情转场动画",
         "Question-two-仿掌阅转场动画"
        ],
    
        ["PictureBrowse"]
    ]
    
    let controllerArray = [
        
        ["NavCATransitionFirstViewController",
         "ModalCATransitionFirstViewController"
        ],
    
        ["NavBaseFirstViewController",
         "NavKuGouTransitionViewController",
         "NavWeChatViewController",
         "NavBaseInteractiveFirstViewController",
         "NavKuGouInteractiveViewController",
         "NavWeChatInteractiveViewController"
        ],
    
        ["ModalBaseViewController",
         "ModalKuGouViewController",
         "ModalWeChatViewController",
         "ModalKuGouInteractiveViewController",
         "ModalWeChatInteractiveViewController"
        ],
    
        ["QuestionsOneFirstViewController",
         "QuestionTwoFirstViewController"
        ],
    
        ["PictureFirstViewController"]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

}


extension TransitionHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTextArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)")!
        cell.backgroundColor = UIColor.backgroundColor()
        cell.textLabel?.text = cellTextArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 34))
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = sectionTitleArray[section]
        label.textAlignment = .center
            
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controllerName = Bundle.main.namespance + "." + controllerArray[indexPath.section][indexPath.row]
        let controller = NSClassFromString(controllerName) as? UIViewController.Type
        navigationController?.pushViewController(controller!.init(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34.0
    }
    
}
