//
//  IconContainerView.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class IconContainerView: UIView {

    lazy var iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var containerView : UIView = {
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

    convenience init(_ icon : UIImage?) {
        self.init()
        commonInit()
        iconView.image = icon
    }
    
    func commonInit() {

        addSubview(iconView)
        addSubview(containerView)
        makeConstraints()
    }
    
    func makeConstraints() {

        iconView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(iconView.snp.trailing)
        }
        
    }
    
    func prepareContainerView(view : UIView) { containerView.addSubview(view) }
    

}
