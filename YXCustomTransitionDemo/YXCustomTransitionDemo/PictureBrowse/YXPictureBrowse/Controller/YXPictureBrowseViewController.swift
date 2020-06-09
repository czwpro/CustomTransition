//
//  YXPictureBrowseViewController.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

let kBrowseSpace: CGFloat = 50.0

class YXPictureBrowseViewController: UIViewController {

    private var transitionImgViewCenter = CGPoint.zero
    
    var animatedTransition: YXPictureBrowseInteractiveAnimatedTransition?
    var dataSouceArray = [YXPictureBrowseSouceModel]()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        // 布局方式改为从上至下，默认从左到右
        flowLayout.scrollDirection = .horizontal
        // Section Inset就是某个section中cell的边界范围
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        // 每行内部cell item的间距
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: yx_screenWidth + kBrowseSpace, height: yx_screenHeight), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = nil
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(YXPictureBrowserCell.self, forCellWithReuseIdentifier: "\(YXPictureBrowserCell.self)")
        return collectionView
    }()
    
    private lazy var imgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        view.isUserInteractionEnabled = true
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(collectionView)
        view.addSubview(imgView)
        
        //指定对应图片
        collectionView.scrollToItem(at: IndexPath(row: animatedTransition!.transitionParameter!.transitionImgIndex, section: 0), at: .left, animated: true)
        
        //隐藏状态栏
        _ = prefersStatusBarHidden
        
        //添加滑动手势
        let interactiveTransitionRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(gestureRecognizer:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func interactiveTransitionRecognizerAction(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer .translation(in: gestureRecognizer.view)
        var scale = 1 - (translation.y / yx_screenHeight)
        scale = scale < 0 ? 0 : scale
        scale = scale > 1 ? 1 : scale
        
        switch gestureRecognizer.state {
        case .possible: break
        case .began:
            setupBaseViewControllerProperty(cellIndex: animatedTransition!.transitionParameter!.transitionImgIndex)
            collectionView.isHidden = true
            imgView.isHidden = false
            
            animatedTransition?.transitionParameter?.gestureRecognizer = gestureRecognizer
            dismiss(animated: true, completion: nil)
        case .changed:
            imgView.center = CGPoint(x: transitionImgViewCenter.x + translation.x * scale, y: transitionImgViewCenter.y + translation.y)
            imgView.transform = CGAffineTransform(scaleX: scale, y: scale)
        case .failed, .cancelled, .ended:
            if scale > 0.95 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.imgView.center = self.transitionImgViewCenter
                    self.imgView.transform = CGAffineTransform.identity
                }) { _ in
                    self.imgView.transform = CGAffineTransform.identity
                }
                print("secode VC 取消")
                self.collectionView.isHidden = false
                self.imgView.isHidden = true
            }
            animatedTransition!.transitionParameter!.transitionImage = self.imgView.image
            animatedTransition!.transitionParameter!.currentPanGestImgFrame = self.imgView.frame
            animatedTransition!.transitionParameter!.gestureRecognizer = nil
            
        @unknown default: break
        }
    }

    func setupBaseViewControllerProperty(cellIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: cellIndex, section: 0)) as! YXPictureBrowserCell
        
        animatedTransition!.transitionParameter!.transitionImage = cell.pictureImageScrollView.zoomImageView.image
        animatedTransition!.transitionParameter!.transitionImgIndex = cellIndex
        
        imgView.frame = cell.pictureImageScrollView.zoomImageView.frame
        imgView.image = cell.pictureImageScrollView.zoomImageView.image
        imgView.isHidden = true
        transitionImgViewCenter = imgView.center
        
    }
}


extension YXPictureBrowseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width + kBrowseSpace, height: view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(YXPictureBrowserCell.self)", for: indexPath) as! YXPictureBrowserCell
        cell.showWithModel(model: dataSouceArray[indexPath.row])
        cell.delegate = self
        cell.cellIndex = indexPath.row
        return cell
    }
}

// Scrollview Delegate
extension YXPictureBrowseViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = collectionView.contentOffset.x
        let cellIndex = offset / (yx_screenWidth + kBrowseSpace)
        setupBaseViewControllerProperty(cellIndex: Int(cellIndex))
    }
}


extension YXPictureBrowseViewController: YXPictureBrowserCellDelegate {
    
    func imageViewClick(cellIndex: Int) {
        dismiss(animated: true, completion: nil)
    }
}
















