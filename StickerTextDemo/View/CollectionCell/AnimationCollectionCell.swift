//
//  AnimationCollectionCell.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 08/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class AnimationCollectionCell: UICollectionViewCell {

    static let cellIdentifier = "AnimationCollectionCell"

    lazy var lblText : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = "Hello"
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 20.0)
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.clipsToBounds = true 
        addSubview(lblText)
        makeConstraints()
        
    }
    
    func makeConstraints() {
        lblText.snp.makeConstraints { (make) in
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
    }


    var animationDM : AnimationDM! {
        didSet {
            lblText.text = animationDM.text
            if let animationLayer = animationDM.animation.getAnimation(
                layer: self.lblText.layer,
                layerRect: self.contentView.frame,
                containerView: self.contentView) {
                lblText.layer.add(animationLayer, forKey: animationDM.keyPath)
            }
            self.layer.borderColor = animationDM.isSelected ? UIColor.red.cgColor : UIColor.white.cgColor
        }
    }
    
}

