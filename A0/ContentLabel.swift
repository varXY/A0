//
//  ContentLabel.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

class ContentLabel: UILabel {
    
    var status: String!
    
    init(text: String, status: String) {
        super.init(frame: CGRectMake(10, 5, ScreenWidth - 20, 100))
        self.status = status
        numberOfLines = 0
        setContent(text)
    }
    
    func setContent(text: String) {
        self.attributedText = text == "" ? textWithStyle("Tapp To Add", colorStatus: status) : textWithStyle(text, colorStatus: status)
        frame.size.width = ScreenWidth - 20
        sizeToFit()
        center.x = ScreenWidth / 2
        if frame.size.height < 100 { frame.size.height = 100 }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
