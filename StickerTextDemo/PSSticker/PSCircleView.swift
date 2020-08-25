//
//  PSCircleView.swift
//  WaterMark
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 Lonely Boy. All rights reserved.
//

import UIKit

class PSCircleView: UIView {

    var color         : UIColor! = .white {
        didSet {
            if oldValue != color {
                self.setNeedsDisplay()
            }
        }
    }
    
    var borderColor   : UIColor! = .white {
        didSet {
            if oldValue != borderColor {
                self.setNeedsDisplay()
            }
        }
        
    }

    var borderWidth   : CGFloat! = 1.0 {
        didSet {
            if oldValue != borderWidth {
                self.setNeedsDisplay()
            }
        }
    }
    var radius        : CGFloat! = 0

    var touchUpInside : (()->(Void))? = nil
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, image: nil)
    }
    
    init(frame : CGRect, image : UIImage?) {
        super.init(frame : frame)
        self.backgroundColor = .clear
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        self.buttonConfiguration(button: button)
         button.frame = self.frame;
        self.addSubview(button)
        self.initGestures()
    }
    func initGestures() {
        self.isUserInteractionEnabled = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let button = self.subviews[0] as? UIButton
        self.buttonConfiguration(button: button ?? UIButton())
        self.initGestures()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
     
        let context = UIGraphicsGetCurrentContext()
        
        var rct = self.bounds;
        rct.origin.x = 0.5 * (rct.width - self.radius * rct.width)
        rct.origin.y = 0.5 * (rct.height - self.radius * rct.height)
        rct.size.width = self.radius * rct.width
        rct.size.height = self.radius * rct.height
        
        context?.setFillColor(self.color.cgColor)
        context?.fill(rct)
        context?.setStrokeColor(self.borderColor.cgColor)
        context?.setLineWidth(self.borderWidth)
        context?.fillEllipse(in: rct)
    }
    
    func buttonConfiguration(button : UIButton) {
        button.layer.cornerRadius = frame.width / 2.0;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.white
        button.isUserInteractionEnabled = false
    }
    @objc func viewDidTap(_ gesture : UITapGestureRecognizer) {
        self.touchUpInside?()
    }
}
