//
//  ChartUtils.swift
//  TryDrawChart
//
//  Created by 竹田 on 2015/10/5.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import Foundation
import UIKit

internal class ChartUtils {
    
    internal class func drawText(context context: CGContext?, text: String, var point: CGPoint, align: NSTextAlignment, attributes: [String : AnyObject]?) {
        if align == .Center {
            point.x -= text.sizeWithAttributes(attributes).width / 2.0
        } else if align == .Right {
            point.x -= text.sizeWithAttributes(attributes).width
        }
        
        UIGraphicsPushContext(context)
        (text as NSString).drawAtPoint(point, withAttributes: attributes)
        UIGraphicsPopContext()
    }
    
}



public func UIGraphicsPushContext(context: CGContext?) {
    
    guard let context = context else {
        return
    }
    
    UIGraphicsPushContext(context)
    
}
