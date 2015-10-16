//
//  ViewController.swift
//  TryDrawChart2
//
//  Created by 竹田 on 2015/10/8.
//  Copyright © 2015年 ChuroCat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        addChartView()
    }
    
    func addChartView() {
        let data = prepareForData()
        lineChartView = LineChartView(frame: scrollView.frame)
        lineChartView.data = data
        
        scrollView.contentSize.width = lineChartView.frame.size.width
        scrollView.addSubview(lineChartView)
    }

    @IBAction func changeLabelPosition() {
        switch lineChartView.axisLabelPosition {
        case .Top:
            lineChartView.axisLabelPosition = .Bottom
        case .Bottom:
            lineChartView.axisLabelPosition = .Top
        }
        lineChartView.setNeedsDisplay()
    }

    func prepareForData() -> ChartData {
        let finalDataEntries1 : [(Int, Double)] = [
            (1440576826, 60.1),
            (1440676827, 61.2),
            (1440876830, 62.1),
            (1440976831, 61.8),
            (1441476831, 61.5),
        ]
        
        let finalDataEntries2 : [(Int, Double)] = [
            (1440776828, 67.9),
            (1440876830, 68.3),
            (1441076801, 63.5),
            (1440976831, 61.5),
            (1441176802, 60.5),
            (1441400005, 62.1),
            (1442400016, 62.1),
        ]

        print("-- finalDataEntries1 -----")
        for dataEntry in finalDataEntries1 {
            print("\(dataEntry.0.dateString)  \(dataEntry.1)")
        }
        
        print("-- finalDataEntries2 -----")
        for dataEntry in finalDataEntries2 {
            print("\(dataEntry.0.dateString)  \(dataEntry.1)")
        }
        
        
        let dataEntries1 = finalDataEntries1.map() { ChartDataEntry(timestamp: $0.0, value: $0.1) }
        let dataEntries2 = finalDataEntries2.map() { ChartDataEntry(timestamp: $0.0, value: $0.1) }
        let dataSet1 = LineChartDataSet(dataEntries: dataEntries1)
        let dataSet2 = LineChartDataSet(dataEntries: dataEntries2)
        
        dataSet1.color = UIColor(red: 254/255, green: 107/255, blue: 137/255, alpha: 1)
        dataSet2.color = UIColor(red: 239/255, green: 192/255, blue: 37/255, alpha: 1)
        
        let data = ChartData(dataSets: [dataSet1, dataSet2])
        
        
        print("-------")
        print("minValue = \(data.valueMin)")
        print("maxValue = \(data.valueMax)")
        print("minTs = \(data.tsMin) \(data.tsMin.dateString)")
        print("maxTs = \(data.tsMax) \(data.tsMax.dateString)")
        
        let dateRange = data.dateRange
        for date in dateRange {
            print("\(date.unixtime.dateString) \(date.dayOfWeek)")
        }
        print("-------")
        
        return data
    }

}

