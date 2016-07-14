//
//  TitleLabel.swift
//  A0
//
//  Created by yao xiao on 7/14/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
        self.text = text
        textColor = UIColor.whiteColor()
        font = UIFont.boldSystemFontOfSize(17)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
