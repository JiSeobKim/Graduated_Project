//
//  ShowMemberInfo.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 29..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ShowMemberInfo : UIViewController {
    
    var getValue : MemberInfo?
    var memberImage : UIImage?
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var photoLabel: UIImageView!
    
    var plist = UserDefaults.standard
    
    override func viewDidLoad() {
        
        if let data = getValue {
            labelName.text = data.name
            labelPhone.text = data.phone
            labelEmail.text = data.email
            labelDate.text = data.date
        }
      
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        let params : Parameters = [
            "name" : labelName.text!
        ]
        postAlamofire(URL: URL_DELETE, params: params, VC: self)
    }
    
}
