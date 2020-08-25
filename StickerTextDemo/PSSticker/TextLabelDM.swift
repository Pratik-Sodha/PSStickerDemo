//
//  TextLabelDM.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 01/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit




class TextLabelDM {

    var text                : String
    var font                : UIFont
    var textColor           : ColorPattern
    var outlineColor        : ColorPattern
    var outlineWidth        : CGFloat

    var characterSpacing    : CGFloat
    var textAlignment       : Int    /* 0- Left, 1-Center, ...*/
    var opacity             : CGFloat
    var shadowOffset        : CGSize
    var shadowColor         : UIColor
    var shadowOpacity       : CGFloat

    var animation           : CAAnimation?
    
    init(text            : String,
         font            : UIFont,
         textColor       : ColorPattern,
         outlineColor    : ColorPattern,
         outlineWidth    : CGFloat,
         characterSpacing: CGFloat = 0,
         textAlignment   : Int = 1,
         opacity         : CGFloat = 1,
         shadowOffset    : CGSize  =  CGSize(width: 5, height: 5),
         shadowColor     : UIColor = UIColor.black,
         shadowOpacity   : CGFloat = 5.0,
         animation       : CAAnimation? = nil
        ) {
     
        self.text             = text
        self.font             = font
        self.textColor        = textColor
        self.shadowOffset     = shadowOffset
        self.shadowColor      = shadowColor
        self.outlineColor     = outlineColor
        self.outlineWidth     = outlineWidth
        self.characterSpacing = characterSpacing
        self.textAlignment    = textAlignment
        self.opacity          = opacity
        self.shadowOpacity    = shadowOpacity
        self.animation        = animation
    }
    
    
    func cloneWith(layout : TextLabelDM) -> TextLabelDM {
        return TextLabelDM(text: self.text,
                           font: UIFont(name: layout.font.fontName, size: self.font.pointSize)!,
                           textColor: layout.textColor,
                           outlineColor: layout.outlineColor,
                           outlineWidth: self.outlineWidth,
                           characterSpacing: self.characterSpacing,
                           textAlignment: self.textAlignment,
                           opacity: self.opacity,
                           shadowOffset : self.shadowOffset,
                           shadowColor : self.shadowColor,
                           shadowOpacity : self.shadowOpacity,
                           animation: self.animation)
    }
    
}

//---------------------------------------------------------
//MARK:-
extension TextLabelDM {
    
    func attributedText(foregroundColor : UIColor) -> NSAttributedString {
     
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.kern : characterSpacing
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func attributedText(rect : CGRect) -> NSAttributedString {
     
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.strokeColor : outlineColor.colorValue(rect: rect),
            NSAttributedString.Key.strokeWidth : outlineWidth,
            NSAttributedString.Key.foregroundColor : textColor.colorValue(rect: rect),
            NSAttributedString.Key.kern : characterSpacing
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}


extension TextLabelDM {
    
    static let dataSource : [TextLabelDM] = {
     
        return [

            TextLabelDM(text: "",
                        font: UIFont.italicSystemFont(ofSize: 25.0),
                        textColor: .gradient(colors: [UIColor(hexString: "#AB3E00"),
                                                      UIColor(hexString: "#732A00")],
                                             orientation : GradientOrientation.horizontal(size: .zero)),
                        outlineColor: .gradient(colors: [UIColor(hexString: "#E67200"),
                                                         UIColor(hexString: "#FFFF00")],
                                                orientation : GradientOrientation.topRightBottomLeft(size: .zero)),
                        outlineWidth: 5.0),
            
            TextLabelDM(text: "",
                        font: UIFont.boldSystemFont(ofSize: 22.0),
                        textColor: .gradient(colors: [UIColor(hexString: "#08E2FF"),
                                                      UIColor(hexString: "#02C2FF"),
                                                      UIColor(hexString: "#00B3FF")],
                                             orientation : GradientOrientation.horizontal(size: .zero)),
                        outlineColor: .plain(color: .white),
                        outlineWidth: 5.0),
            
            TextLabelDM(text: "",
                        font: UIFont.systemFont(ofSize: 25.0),
                        textColor: .gradient(colors: [UIColor(hexString: "#B3BC1C"),
                                                      UIColor(hexString: "#6F8222")],
                                             orientation : GradientOrientation.horizontal(size: .zero)),
                        outlineColor: .plain(color: UIColor(hexString: "#035899")),
                        outlineWidth: 5.0),


            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture1()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture2()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture3()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture4()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture5()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture6()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture7()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture8()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture9()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture10()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture11()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
            TextLabelDM(text: "",
                        font: R.font.pacificoRegular(size: 30.0)!,
                        textColor: .texture(image: R.image.texture12()!),
                        outlineColor: .plain(color: .clear),
                        outlineWidth: 0.0),
        ]
        
    }()
    
}
