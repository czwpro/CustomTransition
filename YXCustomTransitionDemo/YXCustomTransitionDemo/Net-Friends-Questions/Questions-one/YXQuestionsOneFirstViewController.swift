//
//  YXQuestionsOneFirstViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

class YXQuestionsOneFirstViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), style: .plain)
        tableView.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.4, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 220
        tableView.register(YXQuestionOneCell.self, forCellReuseIdentifier: "cellID")
        return tableView
    }()
    
    private let imageDataArray: [UIImage] = {
        var images = [UIImage]()
        for index in 1...5 {
            let pathString = String(format: "BeautyCar%.2d", index)
            let path = Bundle.main.path(forResource: pathString, ofType: "jpg")
            
            guard let imgPath = path else { return images }
            let img = UIImage(contentsOfFile: imgPath)!
            images.append(img)
        }
        return images
    }()
    
    private let animatedTransition = YXQuestionsOneAnimationTrasition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        navigationController?.delegate = nil
    }

}

extension YXQuestionsOneFirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! YXQuestionOneCell
        cell.cellIndex = indexPath.row
        cell.img = imageDataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //1. 设置代理
        self.navigationController?.delegate = animatedTransition
        
        //2. 传入必要的3个参数
        let cell = tableView.cellForRow(at: indexPath) as! YXQuestionOneCell
        animatedTransition.transitionImgView = cell.imgView
        animatedTransition.transitionBeforeImgFrame = getFrameInWindow(view: cell.imgView)
        animatedTransition.transitionAfterImgFrame = backScreenImageViewRectWithImage(image: cell.img!)
        
        // 3.push跳转
        let controller = YXQuestionsOneSecondViewController()
        controller.image = cell.img
        controller.imgFrame = backScreenImageViewRectWithImage(image: cell.img!)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // 获取指定视图在window中的位置
    func getFrameInWindow(view: UIView) -> CGRect {
        return view.superview!.convert(view.frame, to: nil)
    }
    
    func backScreenImageViewRectWithImage(image: UIImage) -> CGRect {
        let size = image.size
        var newSize = CGSize.zero
        newSize.height = screenWidth * 0.6
        newSize.width = newSize.height / size.height * size.width
        
        let imageY: CGFloat = 0
        let imageX: CGFloat = (screenWidth - newSize.width) * 0.5
        
        let rect = CGRect(x: imageX, y: imageY, width: newSize.width, height: newSize.height)
        return rect
    }
}
