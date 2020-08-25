//
//  LayoutCollectionCell.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 04/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class LayoutCollectionCell: UICollectionViewCell {

    lazy var lblText : PSTextLabel = {
        let lable = PSTextLabel(frame: .zero)
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
    
    var lblDM : TextLabelDM! {
        didSet {
            lblDM.text = "A"
            lblText.lableDM = lblDM
            lblText.setNeedsDisplay()
        }
    }
}
