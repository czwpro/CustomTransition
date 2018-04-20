//
//  YXQuestionOneCell.swift
//  YXCustomTransitionDemo
//
//  Created by 蔡志文 on 2018/4/19.
//  Copyright © 2018年 蔡志文. All rights reserved.
//

import UIKit

protocol YXFourTableViewCellDelegate: NSObjectProtocol {
    func imageViewTapClick(cellIndex: Int)
}

class YXQuestionOneCell: UITableViewCell {

    var img: UIImage? {
        didSet {
            imgView.image = img
            let size = backImageNewSize(size: img!.size)
            imgView.frame = CGRect(x: 16, y: 0, width: size.width, height: size.height)
            cellHeight = size.height + 40
        }
    }
    
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    var cellHeight: CGFloat = 0
    
    var cellIndex: Int = 0
    
    weak var delegate: YXFourTableViewCellDelegate?
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgView)
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func backImageNewSize(size: CGSize) -> CGSize {
        var newSize = CGSize.zero
        newSize.height = 200
        newSize.width = newSize.height / size.height * size.width
        return newSize
    }
    
}
