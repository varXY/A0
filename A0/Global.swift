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