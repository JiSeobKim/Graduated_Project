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


