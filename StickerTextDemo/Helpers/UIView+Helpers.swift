//
//  UIView+Helpers.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 06/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func drawGradientColor(colors: [CGColor], orientation: GradientOrientation) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = frame.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }


        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: orientation.startPoint,
                                    end: orientation.endPoint,
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
    
}

