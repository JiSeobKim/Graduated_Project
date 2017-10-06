//
//  AddMmember.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



class DefineStudy: UIViewController {
    
    
    //View variables
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldGoal: UITextField!
    @IBOutlet weak var textFieldPeriod: UITextField!
    
    
    var isExist: String = "Create"
    
    @IBAction func buttonRegist(_ sender: Any) {
        //creating parameters for the post request
        let parameters: Parameters=[
            "name":textFieldName.text!,
            "goal":textFieldGoal.text!,
            "period":textFieldPeriod.text!,
            "exist" : self.isExist
            ]
        
        
        //Sending http post request
        postAlamofire(URL: URL_USER_STUDY_REGISTER, params: parameters, VC: self)

    }
    
    override func viewDidLoad() {
        addInputAccessoryForTextFields(textFields: [textFieldName, textFieldGoal, textFieldPeriod], dismissable: true, previousNextable: true)
        
        
        //통신
        Alamofire.request(URL_GET_STUDYINFO).responseJSON { (response) in
            switch response.result{
            case .success(let data):
                
                
                let dataArray = data as! NSArray
                if dataArray.count != 0 {
                    self.isExist = "Change"
                    let data = dataArray[0] as! NSDictionary
                    self.textFieldName.text = data["name"] as? String
                    self.textFieldGoal.text = data["goal"] as? String
                    self.textFieldPeriod.text = data["period"] as? String
                } else {
                    print("Is Empty")
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    @IBAction func forDataPicker(_ sender: UITextField) {
        upViewForKeyboard(how: 70 , VC:self)
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(DefineStudy.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    @IBAction func forDatePickerEnd(_ sender: UITextField) {
        downViewForKeyboard(how: 70, VC:self)
    }
    
    //타겟시 데이트피커의 값을 텍스트 필드에 넣어주기 위한 펑션
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        textFieldPeriod.text = dateFormatter.string(from: sender.date)
    }
    
    
    
}

