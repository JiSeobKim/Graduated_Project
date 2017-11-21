
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
    var nameArray : [String] = ["Common"]
//for 일반

    var nameData = [String]()
    var textData = [String]()

    //Save 버튼
    @IBAction func saveBtn(_ sender: Any) {
        self.view.endEditing(true)
        
        if nameData.count == 0 {
            alertDalay(viewControl: self, message: "값이 비었어요")
            self.navigationController?.popViewController(animated: true)
        } else {
            
            //입력 받은 값 params에 저장 및 웹 통신
            let params : Parameters = [
                "name" : nameData,
                "text" : textData
            ]
            postAlamofire(URL: URL_REPORT_REGISTER, params: params, VC: self)
        
        }
        
    }
    
    //텍스트 필드에 값 입력시 배열에 추가
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            nameData.append(nameArray[textField.tag])
            textData.append(textField.text!)
        }
    }

    //값 불러오기
    override func viewDidLoad() {
        Alamofire.request(URL_GET_MEMBER).responseJSON { (response) in
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
            cell.commonTextField.delegate = self
            cell.commonTextField.tag = (indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell", for: indexPath) as! AddReportPersonalCell
            cell.name.text = nameArray[indexPath.row]
            
            cell.personalTextField.delegate = self
            cell.personalTextField.tag = (indexPath.row)
            
            return cell
        }
    }
    
}

