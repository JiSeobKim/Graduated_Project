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
import Alamofire

class MainRecent : UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    //표기
    @IBOutlet weak var choicedName: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalDateLabel: UILabel!
    @IBOutlet weak var commonCount: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    
    
    
    struct MemberAndStudyInfo {
        var memberName:[String] = []
        var memberCount:[Double] = []
        var common = "모인 횟수"
        var studyDate = ""
    }
    var mainData = MemberAndStudyInfo()

    
    override func viewDidLoad() {
        barChartView.delegate = self
        choicedName.textColor = UIColor.lightGray
        dDayLabel.underBarColor()
        
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        choicedName.text = "\(mainData.memberName[Int(entry.x)])님은 \(Int(mainData.memberCount[Int(entry.x)]))번 참석!"
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        mainData.memberName = []
        mainData.memberCount = []
        setChart(dataPoints: [], values: [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Alamofire.request(URL_GET_MAIN).responseJSON { (response) in
            switch response.result {
            case .success(let dataAny):
                let dataDic = dataAny as! NSDictionary
                
                //Member Info
                let dataMemberArray = dataDic["member"] as! NSArray
                for row in dataMemberArray {
                    let dataMemberDic = row as! NSDictionary
                    if (dataMemberDic["name"] as! String == "Common"){
                        self.commonCount.text = "\(dataMemberDic["count"] as! Int) 회"
                    } else {
                        self.mainData.memberName.append(dataMemberDic["name"] as! String)
                        self.mainData.memberCount.append(dataMemberDic["count"] as! Double)
                    }
                    
                    
                    if self.mainData.memberName.count != 0{
                        self.setChart(dataPoints: self.mainData.memberName, values: self.mainData.memberCount)
                    }
                }
                
                let dataStudyArray = dataDic["study"] as! NSArray
                let dataStudyDic = dataStudyArray[0] as! NSDictionary
                
                //Insert
                self.goalLabel.text = dataStudyDic["goal"] as? String
                self.mainData.studyDate = dataStudyDic["period"] as! String
                self.goalDateLabel.text = dataStudyDic["period"] as? String
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        self.barChartView.noDataText = """
        새로오신 것을 환영 합니다!
        
        여기에
        
        출석 그래프가 표시됩니다
        """
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let dataSet = BarChartDataSet(values: dataEntries, label: "출석률")
        let data = BarChartData(dataSets: [dataSet])
        dataSet.colors = ChartColorTemplates.vordiplom()
        
        barChartView.data = data
        
        //x축
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelCount = dataPoints.count
        barChartView.xAxis.labelTextColor = UIColor.lightGray
        
        //y축
        barChartView.leftAxis.granularityEnabled = true
        barChartView.leftAxis.granularity = 1.0
        barChartView.leftAxis.labelTextColor = UIColor.lightGray
        barChartView.leftAxis.gridColor = UIColor(red: 254/255, green: 214/255, blue: 84/255, alpha: 1)
        
        //Grid Line
//        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.enabled = false
        

        //기타
        barChartView.legend.textColor = UIColor.lightGray
        barChartView.chartDescription?.text = ""
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.notifyDataSetChanged()
        
        dataSet.drawValuesEnabled = false
    }
    
}



