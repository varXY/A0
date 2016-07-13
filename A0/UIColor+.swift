//
//  UIColor+.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorOfStatus(status: String!) -> UIColor {
        switch status {
        case "0": return UIColor.redColor()
        case "1": return UIColor.greenColor()
        case "2": return UIColor.grayColor()
        default: return UIColor.whiteColor()
        }
    }
}
