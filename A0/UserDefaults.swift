//
//  UserDefaults.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

struct UDKey {
    static let barStatus = "BarStatus"
}

protocol UserDefaults {
    
    var userDefaults: NSUserDefaults { get }
    
    func getColorStatusOfBar() -> String
    func saveColorStatusOfBar(status: String)
}

extension UserDefaults {
    
    var userDefaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    func getColorStatusOfBar() -> String {
        guard let status = userDefaults.valueForKey(UDKey.barStatus) as? String else { return "0" }
        return status
    }
    
    func saveColorStatusOfBar(status: String) {
        userDefaults.setValue(status, forKey: UDKey.barStatus)
        userDefaults.synchronize()
    }
}