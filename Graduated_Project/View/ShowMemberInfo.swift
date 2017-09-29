//
//  ShowMemberInfo.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 29..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit


class ShowMemberInfo : UIViewController {
    
    var getValue : Member_Info?
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelCoin: UILabel!
    
    
    override func viewDidLoad() {
        
        if let data = getValue {
            labelName.text = data.name
            labelPhone.text = data.phone
            labelEmail.text = data.email
            labelCoin.text = data.coin
        }
    }
    
}
