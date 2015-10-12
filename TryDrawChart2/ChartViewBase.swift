//
//  ChartViewBase.swift
//  TryDrawChart2
//
//  Created by 竹田 on 2015/10/8.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import Foundation
import UIKit

class ChartViewBase: UIView {

    // MARK: - Properties

    internal var viewPortHandler: ChartViewPortHandler!
    internal var axisRenderer: ChartAxisRenderer!
    internal var axis: ChartAxis!
    
    var axisLabelPosition = ChartSettings.Axis.Label.Position {
        didSet {
            axis.labelPosition = axisLabelPosition
            calculateOffsets()
        }
    }
    
    /// extra offset to be appended to the viewport's left/top/right/bottom
    var extraLeftOffset: CGFloat   = ChartSettings.ExtraOffset.Left
    var extraTopOffset: CGFloat    = ChartSettings.ExtraOffset.Top
    var extraRightOffset: CGFloat  = ChartSettings.ExtraOffset.Right
    var extraBottomOffset: CGFloat = ChartSettings.ExtraOffset.Bottom

    /// flag that indicates if the chart has been fed with data yet
    internal var dataNotSet = true
    
    /// The data for the chart
    internal var _data: ChartData!
    var data: ChartData? {
        get {
            return _data
        }
        set {
            _data = newValue
            dataNotSet = false
         
            notifyDataSetChanged()
        }
    }

    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializer()
    }
    
    func initializer() {
        self.backgroundColor = UIColor.whiteColor()
        
        viewPortHandler = ChartViewPortHandler()
        viewPortHandler.setChartDimens(width: bounds.size.width, height: bounds.size.height)
        
        axis = ChartAxis(position: axisLabelPosition)
        
        axisRenderer = ChartAxisRenderer(viewPortHandler: viewPortHandler, axis: axis)
    }
    
    // MARK: - Functions
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let frame = self.bounds
        
        if dataNotSet || _data === nil { // check if there is data
            
            CGContextSaveGState(context)
            
            // if no data, inform the user
            let noDataText = "No chart data available."
            let infoFont: UIFont! = UIFont(name: "HelveticaNeue", size: 12.0)
            let infoTextColor = UIColor.redColor()
            
            ChartUtils.drawText(context: context, text: noDataText,
                point: CGPoint(x: frame.width / 2.0, y: frame.height / 2.0),
                align: .Center,
                attributes: [NSFontAttributeName: infoFont, NSForegroundColorAttributeName: infoTextColor]
            )
            
            return
        }
        
        axisRenderer.renderAxisLabels(context: context)
    }

    internal func notifyDataSetChanged() {
        if dataNotSet {
            return
        }
        
        calculateOffsets()
        calcViewWidth()
        
        axisRenderer.setAxis(_data.dateRange)
    }
    
    func calcViewWidth() {
        let axisLabelsWitdh = axis.labelWidth * CGFloat((data?.dateRange.count)!)
        self.frame.size.width = viewPortHandler.offsetLeft + axisLabelsWitdh + viewPortHandler.offsetRight
    }
    
    func calculateOffsets() {
        var offsetLeft   = CGFloat(0.0)
        var offsetTop    = CGFloat(0.0)
        var offsetRight  = CGFloat(0.0)
        var offsetBottom = CGFloat(0.0)
        
        switch axisLabelPosition {
        case .Top:
            offsetTop += axis.labelHeight
        case .Bottom:
            offsetBottom += axis.labelHeight
        }

        // add extra offset
        offsetLeft   += self.extraLeftOffset
        offsetTop    += self.extraTopOffset
        offsetRight  += self.extraRightOffset
        offsetBottom += self.extraBottomOffset
        
        let minOffset = ChartSettings.MinOffset
        viewPortHandler.restrainViewPort(
            offsetLeft:   max(minOffset, offsetLeft),
            offsetTop:    max(minOffset, offsetTop),
            offsetRight:  max(minOffset, offsetRight),
            offsetBottom: max(minOffset, offsetBottom))
    }

}