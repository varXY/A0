//
//  UIColor+.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorInCode(code: [CGFloat]) -> UIColor {
        return UIColor(red: code[0]/255, green: code[1]/255, blue: code[2]/255, alpha: code[3])
    }
    
    class func colorOfStatus(status: String!) -> UIColor {
        switch status {
        case "0": return MyColor.code(24).BTColors[0]
        case "1": return MyColor.code(22).BTColors[0]
        case "2": return MyColor.code(5).BTColors[0]
        default: return UIColor.whiteColor()
        }
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(red: 236/255, green: 235/255, blue: 243/255, alpha: 1.0)
    }
}
