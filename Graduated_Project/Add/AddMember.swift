//
//  AddMember.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddMember: UIViewController {
    
    //Nas
    let URL_USER_REGISTER = "http://222.107.27.68:5123/swift/graduate/registerMember.php"
    
    //View variables
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldCoin: UITextField!
    @IBOutlet weak var labelStatus: UILabel!
    
    
    
    @IBAction func buttonRegist(_ sender: Any) {
        //creating parameters for the post request
        labelStatus.text = ""
        if textFieldCoin.text == "" {
            textFieldCoin.text = "0"
        }
        let parameters: Parameters=[
            "name":textFieldName.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!,
            "coin":textFieldCoin.text!,
            ]
        
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters , encoding: URLEncoding.httpBody).responseJSON
            {
                response in
                //getting the json value from the server
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    self.labelStatus.text = "상태 : \(jsonData["message"] as! String)"
                    
                }
        }
    }
    //Button action
    @IBAction func buttonRegister(_ sender: UIButton) {
        
        
        
    }
    
    
}
