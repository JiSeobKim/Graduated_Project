//
//  RecentMain.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Charts


class MainRecent : UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    var months:[String] = ["Jan","Feb","Mar","Apr","Jun","Jul","Aug"]
    let unitsSold = [20.0, 4.0, 6.0 ,3.0,12.0,16.0, 4.0, 18.0]
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "새로 오신것을 환영합니다!"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let dataSet = BarChartDataSet(values: dataEntries, label: "출석률")
        let data = BarChartData(dataSets: [dataSet])
        dataSet.colors = ChartColorTemplates.vordiplom()
        barChartView.data = data
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.granularity = 1
        barChartView.chartDescription?.text = ""
        barChartView.gridBackgroundColor = UIColor.black
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.enabled = false
        
        
        
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.notifyDataSetChanged()
       
        
    }
}



