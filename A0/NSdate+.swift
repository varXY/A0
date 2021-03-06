//
//  NSdate+.swift
//  D4
//
//  Created by 文川术 on 4/13/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

extension NSDate {

	enum Fomatter: String {
		case MMddyy = "MM/dd/yy"
		case HH = "HH"
		case dd = "dd"
		case MMddyyHHmm = "MM/dd/yy, HH:mm"
		case HHmm = "HH:mm"
		case MMdd = "MM/dd"
        case id = "MMddyyHHmm"
	}
    
    func dateID() -> Int {
        return Int(self.string(.id))!
    }

	func string(fomatter: Fomatter) -> String {
		let dateFomatter = NSDateFormatter()
		dateFomatter.dateFormat = fomatter.rawValue
		let stringDate = dateFomatter.stringFromDate(self)
		return stringDate
	}

	class func getDateWithString(string: String) -> NSDate {
		let dateFomatter = NSDateFormatter()
		dateFomatter.dateFormat = Fomatter.MMddyyHHmm.rawValue
		let date = dateFomatter.dateFromString(string + ", 00:00")!
		return date
	}

	class func specificDate(tomorrow tomorrow: Bool, HH: String) -> NSDate {
		let dateFomatter = NSDateFormatter()
		dateFomatter.dateFormat = Fomatter.MMddyyHHmm.rawValue
		let day = tomorrow ? NSDate(timeIntervalSinceNow: 86400) : NSDate()
		let specificDate = dateFomatter.dateFromString(day.string(.MMddyy) + ", " + HH + ":00")!
		return specificDate
	}
}