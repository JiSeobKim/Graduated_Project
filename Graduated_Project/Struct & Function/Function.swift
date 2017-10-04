//
//  Function.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
let ad = UIApplication.shared.delegate as! AppDelegate

protocol stringData {
    func updateArray(data : String)
}

//완료시 알림창
func alertDalay(viewControl : UIViewController, message : String ){
    
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    
    //폭 조절
    let widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: alert.view.subviews[0], attribute:
        NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 140.0)
    
    alert.view.addConstraint(widthConstraint)
    viewControl.present(alert, animated: true, completion: nil)
    
    let when = DispatchTime.now() + 1
    DispatchQueue.main.asyncAfter(deadline: when) {
        alert.dismiss(animated: true, completion: {
            viewControl.navigationController?.popViewController(animated: true)
        })
        
        
    }
    
    
    
    
}
