//
//  PSStickerView.swift
//  WaterMark
//
//  Created by mac on 27/10/18.
//  Copyright © 2018 Lonely Boy. All rights reserved.
//

import UIKit

protocol PSStickerViewInteractonDelegate {
    func stickerView(_ sticker : PSStickerView, didDoubleTapForView interactionView : PSTextLabel)
    func stickerViewTextEditOperationPerform(_ sticker : PSStickerView, withOptions options : Any?)
    func stickerViewResignResponder()
}

class PSStickerView: UIView {

    var label       : PSTextLabel!
    fileprivate var contentView : UIView!
    
    fileprivate lazy var deleteView : PSCircleView! = {
        
        let button =  PSCircleView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), image: #imageLiteral(resourceName: "iconCross"))
        button.center = CGPoint(x: 20, y:  20)
        return button
    }()

    fileprivate lazy var resizeView : PSCircleView! = {
        
        let button =  PSCircleView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), image: #imageLiteral(resourceName: "iconCross"))
        let sourceView : UIView = self
        button.center = CGPoint(x : sourceView.frame.size.width - 20, y: sourceView.frame.size.height  - 20)
                button.autoresizingMask = [.flexibleLeftMargin , .flexibleTopMargin ]
        return button
    } ()
    
    fileprivate lazy var editView : PSCircleView! = {
        
        let button =  PSCircleView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), image: #imageLiteral(resourceName: "iconEdit"))
        let sourceView : UIView = self
        button.center = CGPoint(x : sourceView.frame.size.width + sourceView.frame.origin.x - 10, y: sourceView.frame.size.height + sourceView.frame.origin.y - 10)
        button.autoresizingMask = [.flexibleLeftMargin , .flexibleBottomMargin]
        return button
    } ()
    
    var _scale : CGFloat!
    var _arg   : CGFloat!
    
    var _initialPoint : CGPoint!
    var _initialArg   : CGFloat!
    var _initialScale : CGFloat!
    
    var interactionDelegate : PSStickerViewInteractonDelegate? = nil
    

    class func setActiveStickerView(_ view: PSStickerView?) {
        struct Operational {
            static var activeView : PSStickerView? = nil
        }
        if view != Operational.activeView {
            Operational.activeView?.setActive(false)
            Operational.activeView = view
            Operational.activeView?.setActive(true)
            
            if let aView = Operational.activeView {
                aView.superview?.bringSubviewToFront(aView)
            }
        }
    }

    func setActive(_ active : Bool) {
        deleteView.isHidden = !active
        resizeView.isHidden = !active
        editView.isHidden = !active
        contentView.layer.borderWidth = (active) ? CGFloat(floatLiteral: CGFloat.NativeType(1/_scale)) : CGFloat(integerLiteral: 0)
    }
    
    //----------------------------------------------
    //MARK: -

    init(frame : CGRect, textDM : TextLabelDM) {

        super.init(frame: frame)
        contentView = UIView(frame: CGRect(origin: .zero, size: frame.size))

        contentView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(contentView)

        label = PSTextLabel(frame: frame, lableDM: textDM)
        self.addSubview(label)

        self.commonConfiguration()
        self.setScale(1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonConfiguration () {
        self.addSubview(deleteView)
        self.addSubview(resizeView)
        
        _scale = 1
        _arg = 0
        self.initGestures()
        
        deleteView.touchUpInside = {
            print("::== Delete Operation ==::")
            print(self, "Line ::= ",#line,"Method ::==",#function)
            self.pushedDelete()
            self.interactionDelegate?.stickerViewResignResponder()
        }
        
        editView.touchUpInside = {
            print("::== Edit Operation ==::")
            print(self, "Line ::= ",#line,"Method ::==",#function)
            self.interactionDelegate?.stickerViewResignResponder()
            self.interactionDelegate?.stickerViewTextEditOperationPerform(self, withOptions: nil)
        }
    }
    
    func initGestures() {
        contentView.isUserInteractionEnabled = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        singleTap.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(viewDidDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
        
        contentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(viewDidPan(_:))))
        resizeView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(resizeViewDidPan(_:))))
    }
    
    @objc func viewDidTap(_ gesture : UITapGestureRecognizer) {
        print(self, "Line ::= ",#line,"Method ::==",#function)
        let index = self.superview?.subviews.firstIndex(of: self)
        self.superview?.exchangeSubview(at: index!, withSubviewAt: 0)
        PSStickerView.setActiveStickerView(self)
        self.interactionDelegate?.stickerViewResignResponder()
    }
    
    @objc func viewDidDoubleTap(_ gesture : UITapGestureRecognizer) {
         print(self, "Line ::= ",#line,"Method ::==",#function)
        PSStickerView.setActiveStickerView(self)
        self.interactionDelegate?.stickerViewResignResponder()
        self.interactionDelegate?.stickerView(self, didDoubleTapForView: label)
    }
    
    @objc func viewDidPan(_ gesture : UIPanGestureRecognizer) {

        PSStickerView.setActiveStickerView(self)

        let point = gesture.translation(in: self.superview)
        if gesture.state == UIGestureRecognizer.State.began {
            _initialPoint = self.center
        }
        self.center = CGPoint(x: _initialPoint.x + point.x, y: _initialPoint.y + point.y)

    }
    
    @objc func resizeViewDidPan(_ gesture : UIPanGestureRecognizer) {
        
        var point = gesture.translation(in: self.superview)
        struct TempMovement {
            static var tmpR : CGFloat = 1
            static var tmpA : CGFloat = 0
        }

        if gesture.state == .began {
            _initialPoint = self.superview?.convert(resizeView.center,
                                                    from: resizeView.superview)
            let point = CGPoint(x : _initialPoint.x - self.center.x,y: _initialPoint.y - self.center.y);
            TempMovement.tmpR = sqrt(point.x * point.x + point.y * point.y)
            TempMovement.tmpA = atan2(point.y, point.x)
            
            _initialArg = _arg
            _initialScale = _scale
        }
        point = CGPoint(x : _initialPoint.x + point.x - self.center.x,y: _initialPoint.y + point.y - self.center.y);
        let R = sqrt(point.x * point.x + point.y * point.y);
        let arg = atan2(point.y, point.x);

        _arg   = _initialArg + arg - TempMovement.tmpA;
        self.setScale(max(_initialScale * R / TempMovement.tmpR, 0.5))

    }
    func pushedDelete () {

        var nextTarget: PSStickerView? = nil
        guard let index = self.superview?.subviews.firstIndex(of: self) else {
            return
        }


        for i in index + 1..<(self.superview?.subviews.count)! {
            let view = superview?.subviews[i]
            if (view is PSStickerView) {
                nextTarget = view as? PSStickerView
                break
            }
        }
        
        if nextTarget == nil {
            var i = index - 1
            while i >= 0 {
                let view = superview?.subviews[i]
                if (view is PSStickerView) {
                    nextTarget = view as? PSStickerView
                    break
                }
                i -= 1
            }
        }
        
        PSStickerView.setActiveStickerView(nextTarget)
        removeFromSuperview()

    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
 
    func setScale(_ scale : CGFloat, isChangeXY : Bool = true) {
        _scale = scale;
        self.transform = CGAffineTransform.identity
        
        contentView.transform = CGAffineTransform(scaleX: _scale, y: _scale)
        var rct = self.frame
        if isChangeXY {
            rct.origin.x += (rct.size.width - (contentView.frame.width + 32)) / 2
            rct.origin.y += (rct.size.height - (contentView.frame.height + 32)) / 2
            rct.size.width = contentView.frame.width + 32
            rct.size.height = contentView.frame.height + 32
            self.frame = rct
        } else {
            rct.size.width = contentView.frame.width + 32
            rct.size.height = contentView.frame.height + 32
            self.frame.size = rct.size
        }

        contentView.center = CGPoint(x: rct.width / 2, y: rct.height / 2)
        label.frame = contentView.frame
        label.setNeedsDisplay()

        self.transform = CGAffineTransform(rotationAngle: _arg)
        
        contentView.layer.borderWidth = 1/_scale
        contentView.layer.cornerRadius = 3/_scale

    }
    private var itterativeLabel : PSTextLabel!
    
}

extension PSStickerView {
    
    func change(layout : TextLabelDM ) {
        label.lableDM = label.lableDM?.cloneWith(layout: layout)
    }
    
    func change(font : UIFont) {
        let fontSize = label.lableDM?.font.pointSize ?? font.pointSize
        label.lableDM?.font = UIFont(name: font.fontName, size: fontSize) ?? font
        label.setNeedsDisplay()
    }
    
    func change(pointSize : Float) {
        guard let font = UIFont(name: label.font.fontName, size: CGFloat(pointSize)) else {
            return
        }
        label.lableDM?.font = font
        label.setNeedsDisplay()
    }
    
    func change(characterSpacing : Float) {
        label.lableDM?.characterSpacing = CGFloat(characterSpacing)
        label.setNeedsDisplay()
    }
    
    func change(textAlignment : Int) {
        guard label.lableDM?.textAlignment != textAlignment else {
            return
        }
        label.lableDM?.textAlignment = textAlignment
        label.setNeedsDisplay()
    }
    
    func change(opacity : Float) {
        label.lableDM?.opacity = CGFloat(opacity)
        label.setNeedsDisplay()
    }
    
    func change(textColor : ColorPattern) {
        label.lableDM?.textColor = textColor
        label.setNeedsDisplay()
    }
    
    func change(outlineWidth : Float) {
        label.lableDM?.outlineWidth = CGFloat(outlineWidth)
        label.setNeedsDisplay()
    }
    
    func change(outlineColor : ColorPattern) {
        label.lableDM?.outlineColor = outlineColor
        label.setNeedsDisplay()
    }
    
    func change(shadowOffset : Float) {
        let offset = CGFloat(shadowOffset)
        label.lableDM?.shadowOffset = CGSize(width: offset, height: offset)
        label.setNeedsDisplay()
    }
    
    func change(shadowColor : UIColor) {
        label.lableDM?.shadowColor = shadowColor
        label.setNeedsDisplay()
    }
    
    func change(shadowOpacity : Float) {
        label.lableDM?.shadowOpacity = CGFloat(shadowOpacity)
        label.setNeedsDisplay()
    }
 
    func change(animation : CAAnimation?) {
        label.lableDM?.animation = animation
    }
    
}

extension PSStickerView {
    func operationalLayer() -> CALayer {
        itterativeLabel = PSTextLabel(frame: label.frame, lableDM: label.lableDM!)
        itterativeLabel.layer.position = self.center
        itterativeLabel.layer.setAffineTransform(self.transform)
        return itterativeLabel.layer
    }
}
