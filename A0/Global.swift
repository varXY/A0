//
//  Global.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

// 尺寸信息
let ScreenBounds = UIScreen.mainScreen().bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height
let ScreenCenter = CGPoint(x: ScreenWidth / 2, y: ScreenHeight / 2)
let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.height

// 延迟执行
func delay(seconds seconds: Double, completion: () -> ()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

func textWithStyle(text: String, colorStatus: String) -> NSMutableAttributedString {
//    let style = NSMutableParagraphStyle()
//    style.lineSpacing = 12
//    style.alignment = NSTextAlignment.Center
//    let result = NSMutableAttributedString(string: text, attributes: [NSParagraphStyleAttributeName: style])
//    result.addAttributes([NSForegroundColorAttributeName: colorStatus], range: NSMakeRange(0, result.length))
//    result.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17)], range: NSMakeRange(0, result.length))
    let attributedText = NSMutableAttributedString(string: text)
    attributedText.addAttributes(textAttributes(colorStatus), range: NSMakeRange(0, attributedText.length))
    return attributedText
}


func textAttributes(colorStatus: String) -> [String: AnyObject] {
    let textAttributes = [
        NSParagraphStyleAttributeName: textStyle(),
        NSForegroundColorAttributeName: UIColor.colorOfStatus(colorStatus),
        NSFontAttributeName: UIFont.systemFontOfSize(17)
    ]
    
    return textAttributes
}


func textStyle() -> NSMutableParagraphStyle {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 12
    style.alignment = NSTextAlignment.Center
    return style
}


