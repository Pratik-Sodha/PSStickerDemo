//
//  Animation.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 21/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum AnimationDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}


enum Animation {
    case none
    case bounceLeftToRight
    case bounceRightToLeft
    case bounceTopToBottom
    case bounceBottomToTop
    case spring
    case smallJumpy
    case centerJumpy
    case fadeIn
    case rotation
    case rotationAntiClock
    case twist
    case topRightCorner
    case topLeftCorner
    
    func getAnimation(layer  : CALayer,
                      layerRect : CGRect,
                      containerView : UIView,
                      duration : Double = 1.5,
                      beginTime : Double = 0) -> CAAnimation? {

        switch self {
        case .none:
            return nil
        case .bounceLeftToRight:
            
            return bounce(direction: .leftToRight,
                          layerRect: layerRect,
                          containerRect: containerView.frame,
                           duration: duration,
                           beginTime: beginTime)

        case .bounceRightToLeft:
            
            return bounce(direction: .rightToLeft,
                           layerRect: layerRect,
                           containerRect: containerView.bounds,
                           duration: duration,
                           beginTime: beginTime)

        case .bounceTopToBottom:
            return bounce(direction: .topToBottom,
                           layerRect: layerRect,
                           containerRect: containerView.bounds,
                           duration: duration,
                           beginTime: beginTime)

        case .bounceBottomToTop:
            return bounce(direction: .bottomToTop,
                           layerRect: layerRect,
                           containerRect: containerView.bounds,
                           duration: duration,
                           beginTime: beginTime)
        case .fadeIn:
            return fadeIn(duration: duration,
                          beginTime: beginTime)
        case .rotation:
            return rotation(antiClock : false,
                            duration: duration,
                            beginTime: beginTime)

        case .rotationAntiClock:
            return rotation(antiClock : true,
                            duration: duration,
                            beginTime: beginTime)
        case .spring:
            return spring(duration: duration, beginTime: beginTime)

        case .twist:
            return twist(duration: duration, beginTime: beginTime)

        case .smallJumpy:
            return smallJumpy(layerRect: layerRect,
                         duration: duration,
                         beginTime: beginTime)
            
        case .centerJumpy:
            return centerJumpy(duration: duration,
                               beginTime: beginTime)
        case .topRightCorner:
            return topRightCornerAnimation(
                layer : layer,
                layerRect: layerRect,
                containerRect: containerView.bounds,
                duration: duration,
                beginTime: beginTime)
            
        case .topLeftCorner:
            return topLeftCornerAnimation(layer: layer,
                                         layerRect: layerRect,
                                         containerRect: containerView.bounds,
                                         duration: duration,
                                         beginTime: beginTime)
        }
    }
    
    
    
    
    var keyPath : String {
        switch self {
        case .none:
            return ""
        case .bounceLeftToRight, .bounceRightToLeft:
            return "position.x"
        case .bounceTopToBottom, .bounceBottomToTop, .smallJumpy:
            return "position.y"
        case .fadeIn:
            return "opacity"
        case .rotation, .rotationAntiClock, .centerJumpy:
            return "transform.rotation"
        case .spring:
            return "transform.scale"
        case .twist:
            return "transform.rotation.y"
        case .topLeftCorner, .topRightCorner:
            return "position"
        }
    }
    
    var text : String {
        switch self {
        case .none:
            return "None"
        default:
            return "Hello"
        }
    }

}

//---------------------------------------------------------
//MARK:-
extension Animation {
    
       private func bounce(direction    : AnimationDirection,
                           layerRect     : CGRect,
                           containerRect : CGRect,
                           duration      : Double,
                           beginTime     : Double) -> CASpringAnimation? {

           let animation = CASpringAnimation(keyPath: keyPath)

           var origin = CGPoint.zero
           let target = layerRect.center
    
           switch direction {

           case .leftToRight:
               origin = CGPoint(x: containerRect.size.width + layerRect.size.width,
                                    y: layerRect.origin.y)
               
               animation.fromValue = NSNumber(value: Int32(origin.x))
               animation.toValue = NSNumber(value: Int32(target.x))

           case .rightToLeft:
               
               origin = CGPoint(x: -layerRect.width , y:  layerRect.origin.y)
               animation.fromValue = NSNumber(value: Int32(origin.x))
               animation.toValue = NSNumber(value: Int32(target.x))

           case .topToBottom:
               origin = CGPoint(x: layerRect.center.x, y: (layerRect.minY - containerRect.height))
               animation.fromValue = NSNumber(value: Int32(origin.y))
               animation.toValue = NSNumber(value: Int32(target.y))
               
           case .bottomToTop:
               origin = CGPoint(x: layerRect.center.x, y: (layerRect.height + containerRect.height))
               animation.fromValue = NSNumber(value: Int32(origin.y))
               animation.toValue = NSNumber(value: Int32(target.y))
           }

           animation.duration = duration
           animation.isRemovedOnCompletion = false
           animation.fillMode = .both
           animation.isAdditive = false
           animation.stiffness = 40
           animation.damping = 6
           animation.repeatCount = Float.infinity
           return animation
       }

       private func fadeIn(duration      : Double,
                           beginTime     : Double) -> CABasicAnimation? {

           let animation = CABasicAnimation(keyPath: keyPath)

           animation.duration = duration
           animation.fromValue = NSNumber(value: 0.0)
           animation.toValue = NSNumber(value: 1.0)
           animation.isRemovedOnCompletion = false
           animation.fillMode = .forwards
           animation.repeatCount = Float.infinity
           animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
           return animation
       }

    
    private func rotation(antiClock : Bool,
                          duration      : Double,
                          beginTime     : Double) -> CAAnimation? {
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = NSNumber(value: 0.0)

        if antiClock {
            animation.toValue = NSNumber(value: -Double(.pi * 2.0))
        } else {
            animation.toValue = NSNumber(value: Double(.pi * 2.0))
        }

        animation.isCumulative = true
        animation.repeatCount = Float.infinity

        animation.isRemovedOnCompletion = false
        animation.fillMode = .both
        animation.isAdditive = false

        return animation
    }
    
    
    func spring(duration      : Double,
                beginTime     : Double) -> CASpringAnimation? {
        
        let animation = CASpringAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = NSNumber(value: 0.0)
        animation.toValue = NSNumber(value: 1.0)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .both
        animation.isAdditive = false
        animation.damping = 5
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func twist(duration      : Double,
                       beginTime     : Double) -> CABasicAnimation? {
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = NSNumber(value: 0.0)
        animation.toValue = NSNumber(value: .pi * 1.0)
        animation.isCumulative = true
        animation.repeatCount = 1
        animation.fillMode = .both
        animation.isAdditive = false
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func smallJumpy(layerRect     : CGRect,
                            duration      : Double,
                            beginTime     : Double) -> CABasicAnimation? {
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.repeatCount = Float.infinity
        animation.duration = duration
        animation.autoreverses = true
        animation.fromValue = NSNumber(value: Int32(layerRect.center.y - 10))
        animation.toValue = NSNumber(value: Int32(layerRect.center.y + 10))
        return animation
    }
    
    private func centerJumpy(duration      : Double,
                             beginTime     : Double) -> CAAnimation? {
        
        let animation1 = CABasicAnimation(keyPath: keyPath)
        animation1.duration = duration
        animation1.fromValue = NSNumber(value: 0.0)
        animation1.toValue = NSNumber(value: Double(0.1))
        animation1.isCumulative = true
        animation1.repeatCount = Float.infinity
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = .forwards
        animation1.isAdditive = false
        
        
        let animation2 = CABasicAnimation(keyPath: keyPath)
        animation2.duration = duration
        animation2.fromValue = NSNumber(value: 0.1)
        animation2.toValue = NSNumber(value: -Double(0.2))
        animation2.isCumulative = true
        animation2.repeatCount = Float.infinity
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = .forwards
        animation2.isAdditive = false
        
        let animationGroup = groupAnimation(animations: [animation1,animation2], duration: duration)
        animationGroup.autoreverses = true
        return animationGroup
        
    }
    
    func topRightCornerAnimation(
        layer : CALayer,
        layerRect     : CGRect,
        containerRect : CGRect,
        duration      : Double,
        beginTime     : Double) -> CAAnimation{

        let animationDuration = duration

        let fromAngle : CGFloat = 0.1
        let toAngle : CGFloat = atan2(layer.transform.m12, layer.transform.m11)
        
        var animations : [CAAnimation]  = []
        let fromPosition = CGPoint(x: containerRect.width, y: 20)
        
        let pathAnimation = CAKeyframeAnimation(keyPath: keyPath)
        let path = CGMutablePath()
        path.move(to: fromPosition)
        let controlPoint1 = CGPoint(x: fromPosition.x - layerRect.width, y: fromPosition.y - 50)
        let controlPoint2 = CGPoint(x: layerRect.center.x, y: layerRect.center.y)
       
        path.addCurve(to: layerRect.center,
                      control1:controlPoint1,
                      control2: controlPoint2)

        pathAnimation.path = path
        pathAnimation.duration = animationDuration
        animations.append(pathAnimation)
        
        
        let angleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        angleAnimation.fromValue = fromAngle
        angleAnimation.toValue = toAngle
        angleAnimation.duration = animationDuration
        angleAnimation.isRemovedOnCompletion = false
        angleAnimation.fillMode = .forwards
        angleAnimation.autoreverses = false
        animations.append(angleAnimation)
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.0
        alphaAnimation.toValue = 1.0
        alphaAnimation.duration = animationDuration
        alphaAnimation.isRemovedOnCompletion = false
        alphaAnimation.fillMode = .forwards
        alphaAnimation.autoreverses = false
        animations.append(alphaAnimation)
        
        return groupAnimation(animations: animations,
                              duration: animationDuration)
    }

    func topLeftCornerAnimation(
        layer : CALayer,
        layerRect     : CGRect,
        containerRect : CGRect,
        duration      : Double,
        beginTime     : Double) -> CAAnimation{

        let animationDuration = duration

        let fromAngle : CGFloat = -0.1
        let toAngle : CGFloat = atan2(layer.transform.m12, layer.transform.m11)
        
        var animations : [CAAnimation]  = []
        let fromPosition = CGPoint(x: -layerRect.width, y: 20)
        
        let pathAnimation = CAKeyframeAnimation(keyPath: keyPath)
        let path = CGMutablePath()
        path.move(to: fromPosition)
        let controlPoint1 = CGPoint(x: layerRect.width * 2, y: fromPosition.y - 50)
        let controlPoint2 = CGPoint(x: layerRect.center.x, y: layerRect.center.y)
       
        path.addCurve(to: layerRect.center,
                      control1:controlPoint1,
                      control2: controlPoint2)

        pathAnimation.path = path
        pathAnimation.duration = animationDuration
        animations.append(pathAnimation)
        
        
        let angleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        angleAnimation.fromValue = fromAngle
        angleAnimation.toValue = toAngle
        angleAnimation.duration = animationDuration
        angleAnimation.isRemovedOnCompletion = false
        angleAnimation.fillMode = .forwards
        angleAnimation.autoreverses = false
        animations.append(angleAnimation)
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.0
        alphaAnimation.toValue = 1.0
        alphaAnimation.duration = animationDuration
        alphaAnimation.isRemovedOnCompletion = false
        alphaAnimation.fillMode = .forwards
        alphaAnimation.autoreverses = false
        animations.append(alphaAnimation)
        
        return groupAnimation(animations: animations,
                              duration: animationDuration)
    }
    
    
    private func groupAnimation(animations:[CAAnimation],
                        duration:Double) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.animations = animations
        group.duration = duration
        group.repeatCount = Float.infinity
        group.isRemovedOnCompletion = false
        return group
    }
}

//---------------------------------------------------------
//MARK:-
extension Animation : CaseIterable{}

//---------------------------------------------------------
//MARK:-

class AnimationDM  {
    let animation : Animation
    init(animation : Animation) {
        self.animation = animation
    }
    
    var text : String {
        return animation.text
    }
    var keyPath : String {
        return animation.keyPath
    }
}

extension AnimationDM {
    
    static let dataSource : [AnimationDM] = {
        let allCases = Animation.allCases
        return allCases.map{ AnimationDM(animation: $0)}
    }()
    
}


extension AnimationDM : HSSelectable{}

//---------------------------------------------------------
//MARK:-

private extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

private extension CGRect {
    
    var center : CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
}
