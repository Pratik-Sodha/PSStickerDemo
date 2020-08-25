//
//  GradientOrientation.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 01/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//


import CoreGraphics
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft(size : CGSize)
    case topLeftBottomRight(size : CGSize)
    case horizontal(size : CGSize)
    case vertical(size : CGSize)
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft(let size):
                return (CGPoint(x: 0.0, y: size.height), CGPoint(x: size.width,y: 0.0))
            case .topLeftBottomRight(let size):
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: size.width,y: size.height))
            case .horizontal(let size):
                return (CGPoint(x: 0.0,y: size.height / 2.0), CGPoint(x: size.width,y: size.height / 2.0))
            case .vertical(let size):
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: size.height))
            }
        }
    }
}
extension GradientOrientation {
    
    func bindWithSize(_ size : CGSize) -> GradientOrientation {

        
        switch self {
        case .topLeftBottomRight:
            return .topLeftBottomRight(size: size)
        case .topRightBottomLeft:
            return .topRightBottomLeft(size: size)
        case .horizontal:
            return .horizontal(size: size)
        case .vertical:
            return .vertical(size: size)
        }
        
    }
    
}
