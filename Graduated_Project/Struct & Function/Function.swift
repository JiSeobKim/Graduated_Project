//
//  Function.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 26..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
let ad = UIApplication.shared.delegate as! AppDelegate

//List of URL
let URL_USER_STUDY_REGISTER = "http://222.107.27.68:5123/swift/graduate/regist_Member_Study.php"
let URL_REPORT_REGISTER = "http://222.107.27.68:5123/swift/graduate/registerReport.php"
let URL_GET_MEMBER = "http://222.107.27.68:5123/swift/graduate/get_Member.php"
let URL_GET_STUDYINFO = "http://222.107.27.68:5123/swift/graduate/get_StudyInfo.php"
let URL_GET_LOG = "http://222.107.27.68:5123/swift/graduate/get_Log.php"
let URL_GET_LOG_DETAIL = "http://222.107.27.68:5123/swift/graduate/get_Log_Detail.php"
let URL_GET_MAIN = "http://222.107.27.68:5123/swift/graduate/get_Main.php"


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

func postAlamofire(URL : String, params:Parameters, VC : UIViewController) {
    
    Alamofire.request(URL, method: .post, parameters : params).responseJSON { (jsonData) in
        switch jsonData.result {
        case .success(let data):
            let dataDic = data as! NSDictionary
            let dataString = dataDic["message"] as! String
            
            alertDalay(viewControl: VC, message: dataString)
            
        case .failure(let e):
            print(e.localizedDescription)
            print("Here")
            
        }
    }
    
}

private var materialKey = false
private var labelShadow = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        
        get{
            return materialKey
        }
        
        set{
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 6.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                //검정 그림자
//                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
                //주황 그림자
                self.layer.shadowColor = UIColor(red: 245/255, green: 114/255, blue: 38/255, alpha: 1).cgColor
                //노랑
//                self.layer.shadowColor = UIColor(red: 245/255, green: 114/255, blue: 38/255, alpha: 0.25).cgColor
                
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
            
        }
        
    }
    
    @IBInspectable var labelShadowDesign : Bool {
        get{
            return labelShadow
        }
        
        set{
            labelShadow = newValue
            if labelShadow {
                
                self.backgroundColor = UIColor(red: 171, green: 178, blue: 186, alpha: 1.0)
                //검정 그림자
//                self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                //주황
//                self.layer.shadowColor = UIColor(red: 245/255, green: 114/255, blue: 38/255, alpha: 0.25).cgColor
                //노랑
                self.layer.shadowColor = UIColor(red: 241/255, green: 203/255, blue: 63/255, alpha: 0.25).cgColor
                self.layer.shadowOffset = CGSize(width: 0, height: 2)
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 0.0
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 4.0
                
                
            }
        }
    }
}


