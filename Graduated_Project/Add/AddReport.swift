
//  AddReport.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddReport: UITableViewController, UITextFieldDelegate {
    var nameArray : [String] = []
//for 일반

    
    var nameData = [String]()
    var textData = [String]()
    
    //Nas 주소
    let URL_REPORT_REGISTER = "http://222.107.27.68:5123/swift/graduate/registerReport.php"
    
    //Save 버튼
    @IBAction func test(_ sender: Any) {
        self.view.endEditing(true)
        
//일반 딕셔너리
        let params : Parameters = [
            "name" : nameData,
            "text" : textData
        ]
        Alamofire.request(URL_REPORT_REGISTER, method: .post, parameters : params).responseJSON { (jsonData) in
            switch jsonData.result {

            case .success(let v):
                print(v)
            case .failure(let e):
                print(e.localizedDescription)

            }
        }


        
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            nameData.append(nameArray[textField.tag])
            textData.append(textField.text!)
        }
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

                //reload tableView Cell
                self.tableView.reloadData()


            case .failure(let e):
                print(e.localizedDescription)
            }

        } // end Alamofire
        
        
    }
    
    
    
    
    
}

extension AddReport {
    
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
            
            cell.personalTextField.delegate = self
            cell.personalTextField.tag = (indexPath.row-1)
            
            return cell
        }
    }
    
    
    
}

