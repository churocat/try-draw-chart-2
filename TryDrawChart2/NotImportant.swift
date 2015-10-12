//
//  NotImportant.swift
//  TryDrawChart
//
//  Created by 竹田 on 2015/10/6.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import Foundation

extension Int {
    
    var dateString: String {
        let nsDate = NSDate(timeIntervalSince1970: NSTimeInterval(self))
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(nsDate)
    }
    
    var datetimeString: String {
        let nsDate = NSDate(timeIntervalSince1970: NSTimeInterval(self))
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(nsDate)
    }
    
}


extension NSDate {
    
    var unixtime: Int {
        let timestampWithDummy = self.timeIntervalSince1970.description
        let tokens = timestampWithDummy.componentsSeparatedByString(".")
        return Int(tokens[0]) ?? 0
    }
    
    var unixtimeZeroAM: Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.stringFromDate(self)
        let date = dateFormatter.dateFromString(dateString)!
        return date.unixtime
    }
    
    var zeroAM: NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(self.unixtimeZeroAM))
    }
    
    var nextDate: NSDate {
        return self.dateByAddingTimeInterval(86400)
    }
    
    var day: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self)
    }
    
    var dayOfWeek: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.stringFromDate(self)
    }
}