//
//  Struct.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 27..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation


struct Member_Info : Decodable {
    var name : String
    var email : String
    var phone : String
    var coin : String
}

struct to_do : Decodable{
    var name : String
    var coinChange : Int
    var description : String
    var date : Date
}


