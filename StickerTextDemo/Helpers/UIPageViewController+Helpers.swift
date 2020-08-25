//
//  UIPageViewController+Helpers.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
    
    func getScrollAnimation(_ index : Int, arrayController : [UIViewController]) -> UIPageViewController.NavigationDirection {
        
        if let vc = self.viewControllers?.last {

            if let currentIndex = arrayController.firstIndex(of: vc) {
                
                if index < currentIndex {
                    return .reverse
                } else {
                    return .forward
                }
            }
        }
        return .forward
    }
}
