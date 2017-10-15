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
    
    
    //View variables
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    

    
    
    
    override func viewDidLoad() {
        addInputAccessoryForTextFields(textFields: [textFieldName, textFieldPhone, textFieldEmail ], dismissable: true, previousNextable: true, isTodayOn: false)
        print(UIScreen.main.bounds.height)
    }
    
    //키보드 입력시 뷰 이동
    @IBAction func emailEditBegin(_ sender: UITextField) {
        upViewForKeyboard(how: 100, VC: self)
        print()
    }
    
    @IBAction func emailEditEnd(_ sender: UITextField) {
        downViewForKeyboard(how: 100, VC: self)
    }
    
    
    
    @IBAction func buttonRegist(_ sender: Any) {
        

        //creating parameters for the post request
        let parameters: Parameters=[
            "name":textFieldName.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!,
            ]

        //Sending http post request
        postAlamofire(URL: URL_USER_STUDY_REGISTER, params: parameters, VC: self)
        
    }

   
   
    
}
