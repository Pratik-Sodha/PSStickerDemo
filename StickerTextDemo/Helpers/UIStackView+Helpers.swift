//
//  UIStackView+Helpers.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views : [UIView]) {
        _ = views.map{self.addArrangedSubview($0)}
    }
    
}

