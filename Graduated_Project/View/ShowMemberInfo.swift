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
    
    
    override func viewDidLoad() {
        print(getValue?.name)
    }
    
}
