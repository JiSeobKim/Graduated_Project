//
//  KeyBoard_Tool.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 10. 6..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit

func upViewForKeyboard(how : CGFloat, VC:UIViewController) {
    UIView.animate(withDuration: 0.25, animations: {
        VC.view.frame.origin.y -= how
    }, completion: nil)
}

func downViewForKeyboard(how : CGFloat, VC:UIViewController) {
    UIView.animate(withDuration: 0.25, animations: {
        VC.view.frame.origin.y += how
    }, completion: nil)
}

extension UIViewController{
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false, isTodayOn : Bool) {
        
        
        for (index, textField) in textFields.enumerated() {
            //툴바 사이즈 및 컬러
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.barStyle = UIBarStyle.default
            toolbar.tintColor = UIColor(red: 245/255, green: 114/255, blue: 38/255, alpha: 0.5)
            
            //툴바에 넣을 아이템 배열
            var items = [UIBarButtonItem]()
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            if previousNextable {
                
                //이전 버튼
                let previousButton = UIBarButtonItem(title: "<", style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                //다음 버튼
                let nextButton = UIBarButtonItem(title: ">", style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                
                
                
                //툴바에 쓸 아이템 추가
                if textFields.count != 1{
                    items.append(contentsOf: [previousButton, nextButton])
                }
            }
            
            //Today 버튼
            let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: nil, action: nil)
            todayButton.width = 30
            if isTodayOn, textField == textFields.last {
                todayButton.action = #selector(self.datePickerTodayButton)
                
            } else {
                todayButton.isEnabled = false
                todayButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            }
            
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            
            if textFields.count == 3 {
                items.append(contentsOf: [spacer, todayButton,spacer, doneButton])
            } else {
                items.append(contentsOf: [spacer, doneButton])
            }
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
        
        
    }
    
   
    @objc func datePickerTodayButton(_ a : UIBarButtonItem) {
        let vc = self as? DefineStudy
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        vc?.textFieldPeriod.text = dateFormatter.string(from: todaysDate)
        self.view.endEditing(true)
    }
    
  
}
