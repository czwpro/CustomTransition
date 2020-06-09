//
//  YXPictureBrowserCell.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit
import Kingfisher

protocol YXPictureBrowserCellDelegate: NSObjectProtocol {
    func imageViewClick(cellIndex: Int)
}

class YXPictureBrowserCell: UICollectionViewCell {
    
    var cellIndex: Int = 0
    
    weak var delegate: YXPictureBrowserCellDelegate?
    
    lazy var pictureImageScrollView: YXBrowseZoomScrollView = {
        
        let pictureImageScrollView = YXBrowseZoomScrollView(frame: CGRect(x: 0, y: 0, width: yx_screenWidth, height: yx_screenHeight))
        pictureImageScrollView.backgroundColor = UIColor.black
        pictureImageScrollView.zoomScale = 1.0
        
        pictureImageScrollView.tapBlock = { [weak self] in
            guard let delegate = self?.delegate else { return }
            delegate.imageViewClick(cellIndex: self!.cellIndex)
        }
        
        return pictureImageScrollView
    }()
    
    var model: YXPictureBrowseSouceModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        contentView.addSubview(pictureImageScrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showWithModel(model: YXPictureBrowseSouceModel) {
        self.model = model
        let imageView = pictureImageScrollView.zoomImageView
        let placeholderImage = UIImage(named: "nodata")
        imageView.image = placeholderImage
        setPictureImage(image: placeholderImage!)
        
        if let image = model.image {
            imageView.image = image
        } else if let imgUrlThumb = model.imgUrl_thumb, imgUrlThumb.count > 0 {
            imageView.kf.setImage(with: URL(string: model.imgUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil) { result in
                if case let Result.success(success) = result {
                    self.setPictureImage(image: success.image)
                }
            }
        }
        
        if let imgUrl = model.imgUrl {
            imageView.kf.setImage(with: URL(string: imgUrl), placeholder: placeholderImage, options: nil, progressBlock: nil) { result in
                if case let Result.success(success) = result {
                    self.setPictureImage(image: success.image)
                }
            }
   
        }
    }
    
    func setPictureImage(image: UIImage) {
        let size = backImageSize(image: image)
        
        // 将scrollview的contentSize设置成缩放前
        pictureImageScrollView.contentSize = CGSize(width: size.width, height: size.height)
        pictureImageScrollView.contentOffset = CGPoint.zero
        
        var imageY = (pictureImageScrollView.frame.size.height - size.height) * 0.5
        imageY = imageY > 0 ? imageY : 0
        pictureImageScrollView.zoomImageView.frame = CGRect(x: 0, y: imageY, width: pictureImageScrollView.frame.size.width, height: size.height)
    }
    
    func backImageSize(image: UIImage) -> CGSize {
        let size = image.size
        var newSize = CGSize.zero
        newSize.width = yx_screenWidth
        newSize.height = newSize.width / size.width * size.height
        return newSize
    }
    
    // 获取指定视图在window中的位置
    func getFrameInWindow(view: UIView) -> CGRect {
        return view.convert(view.bounds, to: UIApplication.shared.keyWindow)
    }
    
}
