//
//  MainLog.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MainLog : UITableViewController {
    
    
    var dataArray = [ToDoInfo]()

    
    override func viewWillAppear(_ animated: Bool) {
        dataArray = []
        Alamofire.request(URL_GET_LOG).responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                let objArray = obj as! NSArray
                
                for row in objArray {
                    do {
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: row, options: .prettyPrinted)
                        self.dataArray.append(try JSONDecoder().decode(ToDoInfo.self, from: jsonData))
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                
                self.tableView.reloadData()
            case . failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        
       
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataArray[indexPath.row]
        performSegue(withIdentifier: "LogDetail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogDetail" {
            if let destination = segue.destination as? MainLogDetail {
                if let data = sender as? ToDoInfo{
                    destination.getCommonData = data
                }
                
            }
        }
    }
    
    
    
    
    
//LogDetail
    
    

}

extension MainLog {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! MainLogCell
        
        cell.labelDate.text = dataArray[indexPath.row].date
        cell.labelDescription.text = dataArray[indexPath.row].description
        
        return cell
    }
    
}
