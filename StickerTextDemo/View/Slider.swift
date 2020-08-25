//
//  Slider.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class Slider: UISlider {

    var valueChangedCompletion : ((Float) -> (Void))? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init(initialValue : Float,minimumValue : Float, maximumValue : Float) {
        self.init(frame: .zero)
        commonInit()
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.value = initialValue
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    @objc func valueChanged(_ slider : UISlider) {
        valueChangedCompletion?(slider.value)
    }
    
}
