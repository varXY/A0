//
//  NavigationViewController.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var colorOfImage: UIColor!

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.barTintColor = MyColor.code(24).BTColors[0]
		navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(17)
        ]
		navigationBar.translucent = false

//		setbackgoundColorImage(UIColor.colorOfStatus("0"))
//      navigationBar.shadowImage = UIImage.imageWithColor(UIColor.clearColor(), rect: CGRectMake(0, 0, 10, 10))

    }
    
    func setbackgoundColorImage(color: UIColor) {
        let rect = CGRectMake(0, 0, self.view.frame.width, 64)
        self.navigationBar.setBackgroundImage(UIImage.imageWithColor(color, rect: rect), forBarMetrics: UIBarMetrics.Default)
    }

}
