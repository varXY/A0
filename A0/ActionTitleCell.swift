//
//  ActionTitleCell.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

class ActionTitleCell: UITableViewCell {
    
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.clearColor()
        
        titleLabel = UILabel(frame: CGRectMake(5, 2.5, ScreenWidth - 10, 60 - 5))
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        contentView.addSubview(titleLabel)
        
    }
    
    
    func configureCell(action: [String]) {
        titleLabel.backgroundColor = UIColor.colorOfStatus(action[1])
        titleLabel.text = action[2]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
