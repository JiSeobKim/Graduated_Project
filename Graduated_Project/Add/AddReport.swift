//
//  AddReport.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddReport: UITableViewController {
    var nameArray : [String] = []
    var commonStr : AddReportCommonCell?
    var personalStr : AddReportPersonalCell?
    
    @IBAction func test(_ sender: Any) {
        
        let index = IndexPath(row: 2, section: 0)
        let cell : AddReportPersonalCell = self.tableView.cellForRow(at: index) as! AddReportPersonalCell
        let a = cell.personalTextField.text!
        print(a)
        
    }
    var URL = "http://222.107.27.68:5123/swift/graduate/getMember.php"

    override func viewDidLoad() {
        Alamofire.request(URL).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                
                let dataArray = data as! NSArray
                
                for row in dataArray {
                    let nameDic = row as! NSDictionary
                    self.nameArray.append(nameDic["name"] as! String)
                
                }
                
                
                self.tableView.reloadData()
                
                
            case .failure(let e):
                print(e.localizedDescription)
            }
            
        } // end Alamofire
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return nameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! AddReportCommonCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell", for: indexPath) as! AddReportPersonalCell
            cell.name.text = nameArray[indexPath.row - 1]
            return cell
            
        }
        
        
    }
    
}
