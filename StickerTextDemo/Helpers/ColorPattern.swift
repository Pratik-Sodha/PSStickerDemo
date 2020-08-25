//
//  ColorPattern.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 06/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit

enum ColorPattern {
    case plain(color : UIColor)
    case gradient(colors : [UIColor], orientation : GradientOrientation)
    case texture(image : UIImage)
   
}

//---------------------------------------------------------
//MARK:- Helpers

extension ColorPattern {
    
    func colorValue(rect : CGRect = .zero) -> UIColor {
        
        switch self {
        case .plain(let color):
            return color

        case .gradient(let colors, let orientation):
            return self.drawGradientColor(in: rect, colors: colors.cgColors, orientation: orientation.bindWithSize(rect.size)) ?? .black

        case .texture(let image):
            return UIColor(patternImage: image)
        }
    }
    
    
    private func drawGradientColor(in rect: CGRect, colors: [CGColor], orientation: GradientOrientation) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
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


//---------------------------------------------------------
//MARK:- Data

extension ColorPattern {
    
    static let dataSoure : [ColorPattern] = {
       
        return [
            ColorPattern.plain(color: .white),
            ColorPattern.plain(color: .black),
            ColorPattern.gradient(colors: [UIColor(hexString: "#ffafbd"), UIColor(hexString: "#ffc3a0")], orientation: .vertical(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#2193b0"), UIColor(hexString: "#6dd5ed")], orientation: .vertical(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#cc2b5e"), UIColor(hexString: "#753a88")], orientation: .horizontal(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#ee9ca7"), UIColor(hexString: "#ffdde1")], orientation: .topLeftBottomRight(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#42275a"), UIColor(hexString: "#734b6d")], orientation: .horizontal(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#bdc3c7"), UIColor(hexString: "#2c3e50")], orientation: .vertical(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#de6262"), UIColor(hexString: "#ffb88c")], orientation: .topLeftBottomRight(size: .zero)),
            ColorPattern.gradient(colors: [UIColor(hexString: "#06beb6"), UIColor(hexString: "#48b1bf")], orientation: .topRightBottomLeft(size: .zero)),
            
            
            ColorPattern.gradient(colors: [UIColor.red, UIColor.yellow], orientation: .horizontal(size: .zero)),
            ColorPattern.gradient(colors: [UIColor.green, UIColor.blue], orientation: .vertical(size: .zero)),
            ColorPattern.gradient(colors: [UIColor.lightGray, UIColor.gray,UIColor.darkGray], orientation: .vertical(size: .zero)),
            ColorPattern.gradient(colors: [UIColor.magenta, UIColor.white], orientation: .topRightBottomLeft(size: .zero)),
            ColorPattern.gradient(colors: [UIColor.white, UIColor.magenta], orientation: .topLeftBottomRight(size: .zero)),
        ]
        
    }()
    
}
