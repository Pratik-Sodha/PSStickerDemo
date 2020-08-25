//
//  PSTextLabel.swift
//  WaterMark
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 Lonely Boy. All rights reserved.
//

import UIKit

class PSTextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        
    }
    
    var lableDM : TextLabelDM? {
        didSet {
            self.text = lableDM?.text
            self.setNeedsDisplay()
        }
    }
    
    convenience init(frame: CGRect,lableDM : TextLabelDM) {
        self.init(frame: frame)
        self.lableDM = lableDM
        self.text = lableDM.text

        commonInit()
    }

    func commonInit() {
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    override func draw(_ rect: CGRect) {

        guard let itterativeLableDM = self.lableDM else {
            super.drawText(in: rect)
            return
        }
        self.font = itterativeLableDM.font
        let shadowOffset = itterativeLableDM.shadowOffset
        let shadowColor = itterativeLableDM.shadowColor
        let shadowOpacity = itterativeLableDM.shadowOpacity


        let drawTextColor = itterativeLableDM.textColor.colorValue(rect: rect)


        let outlineSize = itterativeLableDM.outlineWidth
        let drawOutlineColor = itterativeLableDM.outlineColor.colorValue(rect: rect)


        self.textAlignment = NSTextAlignment(rawValue: itterativeLableDM.textAlignment) ?? .center
        self.alpha = itterativeLableDM.opacity
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(outlineSize)
        context?.setLineCap(.round)

        //outline
        context?.setTextDrawingMode(.stroke)
        self.attributedText = itterativeLableDM.attributedText(foregroundColor: drawOutlineColor)
        super.drawText(in: rect.insetBy(dx: outlineSize/4, dy: outlineSize/4))
        

        //shadow
        context?.setTextDrawingMode(.clip)
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        super.drawText(in: rect.insetBy(dx: outlineSize/4, dy: outlineSize/4))
        
        //text color
        context?.setLineWidth(outlineSize)
        context?.setTextDrawingMode(.fill)
        self.attributedText = itterativeLableDM.attributedText(foregroundColor: drawTextColor)
        super.drawText(in: rect.insetBy(dx: outlineSize/4, dy: outlineSize/4))
        
        self.shadowOffset = shadowOffset
        
    }

}


//---------------------------------------------------------
//MARK:- NOT IN USE

class PSTextLayer: CATextLayer {

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    var lableDM : TextLabelDM? {
        didSet {
            self.string = lableDM?.text
            self.setNeedsDisplay()
        }
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }

    var textLayer : CALayer!

    convenience init(layer: CALayer, lableDM : TextLabelDM) {
        self.init(layer : layer)
        textLayer = layer
        
        self.lableDM = lableDM
        commonInit()
        
    }

    func commonInit() {
        self.isWrapped = true
        self.alignmentMode = .center
        self.truncationMode = CATextLayerTruncationMode.none
        self.allowsFontSubpixelQuantization = true

    }

    var rect : CGRect {
        return CGRect(x: 0, y: 0, width: textLayer.frame.size.width, height: textLayer.frame.size.height)
    }

    override func draw(in ctx: CGContext) {
        guard let itterativeLableDM = self.lableDM else {
            super.draw(in: ctx)
            return
        }
        self.font = itterativeLableDM.font
        self.fontSize = itterativeLableDM.font.pointSize
        let shadowOffset = itterativeLableDM.shadowOffset
        let shadowColor = itterativeLableDM.shadowColor
        let shadowOpacity = itterativeLableDM.shadowOpacity

        
        let drawTextColor = itterativeLableDM.textColor.colorValue(rect: rect)


        let outlineSize = itterativeLableDM.outlineWidth
        let drawOutlineColor = itterativeLableDM.outlineColor.colorValue(rect: rect)

        self.alignmentMode = /*NSTextAlignment(rawValue: itterativeLableDM.textAlignment) ?? */CATextLayerAlignmentMode.center

        let context = ctx

        context.setLineWidth(outlineSize)
        context.setLineCap(.round)

        //outline
        context.setTextDrawingMode(.stroke)
        self.string = itterativeLableDM.attributedText(foregroundColor: drawOutlineColor)
        super.draw(in: context)

        //text color
        context.translateBy(x: 0.0, y: bounds.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setLineWidth(outlineSize)
        context.setTextDrawingMode(.fill)
        self.string = itterativeLableDM.attributedText(foregroundColor: drawTextColor)
        super.draw(in: context)


        //shadow
        context.setTextDrawingMode(.clip)
        self.shadowOffset = shadowOffset
        self.shadowColor = shadowColor.cgColor
        self.shadowOpacity = Float(shadowOpacity)
        super.draw(in: ctx)

        self.shadowOffset = shadowOffset
    }
    

}

