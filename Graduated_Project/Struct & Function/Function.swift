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


extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
//    func moveFrame(){
//        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
//    }
}
