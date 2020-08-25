//
//  ColorPickerCollectionCell.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 06/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class ColorPickerCollectionCell: UICollectionViewCell {

    static let cellIdentifier = "ColorPickerCollectionCell"

    lazy var colorView : UIView = {
        let view = UIView()
        return view
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

        addSubview(colorView)
        makeConstraints()
    }
    
    func makeConstraints() {
        colorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.size.width / 2.0
        colorView.layer.borderColor = UIColor.white.cgColor
        colorView.layer.borderWidth = 1.0
    }
    
    var color : ColorPattern! {
        
        didSet {
            colorView.layoutIfNeeded()
            colorView.backgroundColor = color.colorValue(rect: colorView.frame)            
        }
    }
    
}
