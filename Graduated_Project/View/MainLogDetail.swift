//
//  MainLogDetail.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 10. 8..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class MainLogDetail : UITableViewController {
    
    var getCommonData : ToDoInfo?
    var getArray = [ToDoInfo]()
    
    override func viewDidLoad() {
        
        //get data from web
        if let data = getCommonData {
            print(data.date)
            let param : Parameters = [
                "date" : data.date
            ]
         
            Alamofire.request(URL_GET_LOG_DETAIL, method: .post, parameters: param).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    let dataArray = data as! NSArray
                    for row in dataArray {
                        do {
                            let dataDic = row as! NSDictionary
                            print(dataDic)
                            let dataJSON = try JSONSerialization.data(withJSONObject: row, options: .prettyPrinted)
                            
                            self.getArray.append(try JSONDecoder().decode(ToDoInfo.self, from: dataJSON))
                            
                            
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogDetailCell", for: indexPath) as! MainLogDetailCell
        
        if let getCommonData = getCommonData{
            if indexPath.row == 0 {
                cell.labelName.text = getCommonData.name
                cell.labelDescription.text = getCommonData.description
            } else {
                cell.labelName.text = getArray[indexPath.row - 1].name
                cell.labelDescription.text = getArray[indexPath.row - 1].description
            }
            
        }
        
        
        return cell
    }

    
}
