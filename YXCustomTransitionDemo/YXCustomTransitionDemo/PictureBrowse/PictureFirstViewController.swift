//
//  PictureFirstViewController.swift
//  CustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

let cellImageSize: CGFloat = floor((screenWidth - 2 * 5) / 3.0)

class PictureFirstViewController: UIViewController {

    private let animatedTransition = PictureBrowseInteractiveAnimatedTransition()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        // 布局方式改为从上至下，默认从左到右
        flowLayout.scrollDirection = .vertical
        // Section Inset就是某个section中cell的边界范围
        flowLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        // 每行内部cell item的间距
        flowLayout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: _screenWidth , height: _screenHeight - 64), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(PictureFirstPageCell.self, forCellWithReuseIdentifier: "\(PictureFirstPageCell.self)")
        
        return collectionView
    }()
    
    private var imageDataArray: [Dictionary<String, UIImage>] = {
        var imageDataArray = [Dictionary<String, UIImage>]()
        
        //构造图片数据
        for index in 1...11 {
            let pathString = String(format: "Expression%.2d", index)
            let path = Bundle.main.path(forResource: pathString, ofType: "jpeg")
            
            guard let imgPath = path else { return imageDataArray }
            let img = UIImage(contentsOfFile: imgPath)!
            
            let dict = ["image": img]
            
            imageDataArray.append(dict)
        }
        
        //构造图片数据
        for index in 1...11 {
            let pathString = String(format: "Expression%.2d", index)
            let path = Bundle.main.path(forResource: pathString, ofType: "jpeg")
            
            guard let imgPath = path else { return imageDataArray }
            let img = UIImage(contentsOfFile: imgPath)!
            
            let dict = ["image": img]
            
            imageDataArray.append(dict)
        }
        return imageDataArray
    }()
    
    private lazy var firstImageViewFrames: [NSValue] = {
        var imageFrames = [NSValue]()
        for index in 0..<imageDataArray.count {
            let indexPath = IndexPath(item: index, section: 0)
            var cell = collectionView.cellForItem(at: indexPath) as? PictureFirstPageCell
            
            if let cell = cell {
                //获取当前view在Window上的frame
                let frame = getFrameInWindow(view: cell.imageView)
                imageFrames.append(NSValue(cgRect: frame))
            } else {
                let frame = CGRect.zero
                imageFrames.append(NSValue(cgRect: frame))
            }
        }
        return imageFrames
    }()
    
    //构造图片模型数组
    private lazy var browseSouceModelItemArray: [PictureBrowseSouceModel] = {
        
        var models = [PictureBrowseSouceModel]()
        for (_, imgDict) in imageDataArray.enumerated() {
            var model = PictureBrowseSouceModel()
//            model.imgUrl = imgDict["imgUrl"] as String
//            model.imgUrl_thumb = imgDict["imgUrl_thumb"] as String
            model.image = imgDict["image"]
            models.append(model)
        }
        return models
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = nil
    }

    // 获取指定视图在window中的位置
    func getFrameInWindow(view: UIView) -> CGRect {
        return view.superview!.convert(view.frame, to: nil)
    }
}

extension PictureFirstViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgDict = imageDataArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PictureFirstPageCell.self)", for: indexPath) as! PictureFirstPageCell
        cell.imageView.image = imgDict["image"]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: cellImageSize, height: cellImageSize)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PictureFirstPageCell
        let index = indexPath.item
        
        //封装参数对象
        let transitionParameter = PictureBrowseTransitionParameter()
        transitionParameter.transitionImage = cell.imageView.image
        transitionParameter.firstVCImgFrames = firstImageViewFrames
        transitionParameter.transitionImgIndex = index
      
        animatedTransition.transitionParameter = transitionParameter
        
        //传输必要参数
        let pictureController = PictureBrowseViewController()
        pictureController.modalPresentationStyle = .fullScreen
        pictureController.dataSouceArray = browseSouceModelItemArray
        pictureController.animatedTransition = animatedTransition
        
        // 设置代理
        pictureController.transitioningDelegate = animatedTransition
        present(pictureController, animated: true, completion: nil)
        
    }
}
