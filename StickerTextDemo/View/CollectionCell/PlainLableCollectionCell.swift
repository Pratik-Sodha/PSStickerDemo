//
//  PlainLableCollectionCell.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class PlainLableCollectionCell: UICollectionViewCell {

    lazy var lblText : UILabel = {
        let lable = UILabel(frame: .zero)
        lable.contentMode = .center
        lable.adjustsFontSizeToFitWidth = true
        lable.textColor = .white
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
    
    var font : UIFont! {
        didSet {
            lblText.font = font
            lblText.text = "Hello"
        }
    }
}
