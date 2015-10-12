//
//  ChartSettings.swift
//  TryDrawChart
//
//  Created by 竹田 on 2015/10/7.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import Foundation
import UIKit

struct ChartSettings {

    struct ExtraOffset {
        static let Left: CGFloat   = 20
        static let Right: CGFloat  = 20
        static let Top: CGFloat    = 20
        static let Bottom: CGFloat = 20
    }

    static let MinOffset: CGFloat = 10

    struct  Axis {
        struct Label {
            static let Width: CGFloat = 50
            static let Offset: CGFloat = 5
            static let Position = ChartAxis.LabelPosition.Top
        }
        
        struct DayLabel {
            static let Font = UIFont.systemFontOfSize(18.0)
            static let TextColor = UIColor.blackColor()
        }
        
        struct DayOfWeekLabel {
            static let Font = UIFont.systemFontOfSize(14.0)
            static let TextColor = UIColor.blackColor()
        }
        
        static let StrokeLineOffset: CGFloat = 10
    }

}