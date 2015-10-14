//
//  LineChartDataSet.swift
//  TryDrawChart2
//
//  Created by 竹田 on 2015/10/13.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import Foundation
import UIKit

class LineChartDataSet: ChartDataSet {

    var color = ChartSettings.LineData.Color
    var circleRadius = ChartSettings.LineData.CircleRadius
    
    /// line width of the chart (min = 0.2, max = 10)
    /// **default**: 1
    private var _lineWidth = ChartSettings.LineData.LineWidth
    var lineWidth: CGFloat {
        get {
            return _lineWidth
        }
        set {
            _lineWidth = max(10, min(0.2, newValue))
        }
    }

}