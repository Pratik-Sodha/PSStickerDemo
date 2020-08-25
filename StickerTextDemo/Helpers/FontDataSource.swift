//
//  FontDataSource.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import Foundation
import UIKit
class FontDataSource{
    
    static let dataSource : [UIFont] = {

        return [
            R.font.amaticSCRegular(size: 17.0),
            R.font.dancingScriptRegular(size: 17.0),
            R.font.pacificoRegular(size: 17.0),
            R.font.lobsterRegular(size: 17.0),
            R.font.rockSaltRegular(size: 17.0),
            R.font.monotonRegular(size: 17.0)
            ].compactMap{$0}
    }()
    
}
