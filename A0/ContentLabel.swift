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
        super.init(frame: CGRectMake(5, 2.5, ScreenWidth - 10, 60))
        self.status = status
        self.numberOfLines = 0
        self.textAlignment = .Center
        self.font = UIFont.systemFontOfSize(17)
        self.textColor = text == "" ? UIColor.colorOfStatus(status) : UIColor.blackColor()
        self.text = text == "" ? "Tapp To Add" : text
        self.sizeToFit()
        self.center.x = ScreenWidth / 2
    }
    
    func setContent(text: String) {
        self.frame.size.width = ScreenWidth - 10
        self.textColor = text == "" ? UIColor.colorOfStatus(status) : UIColor.blackColor()
        self.text = text == "" ? "Tapp To Add" : text
        self.sizeToFit()
        self.center.x = ScreenWidth / 2
        print(frame.width)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
