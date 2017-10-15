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



class AddMember: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    //View variables
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var photoViewLabel: UIImageView!
    let imagePicker = UIImagePickerController()
    var originalImage: UIImage!
    
    
    
    override func viewDidLoad() {
        addInputAccessoryForTextFields(textFields: [textFieldName, textFieldPhone, textFieldEmail ], dismissable: true, previousNextable: true, isTodayOn: false)
        print(UIScreen.main.bounds.height)
    }
    
    //키보드 입력시 뷰 이동
    @IBAction func emailEditBegin(_ sender: UITextField) {
        upViewForKeyboard(how: 70, VC: self)
        print()
    }
    
    @IBAction func emailEditEnd(_ sender: UITextField) {
        downViewForKeyboard(how: 70, VC: self)
    }
    
    
    
    @IBAction func buttonRegist(_ sender: Any) {
        
//        if  photoViewLabel.image != UIImage(named: "member"){
//            let data = photoViewLabel.image
//            let imageData = UIImagePNGRepresentation(data!)
//            let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
//        }
        
        let data = photoViewLabel.image
        let imageData = UIImagePNGRepresentation(data!)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        //creating parameters for the post request
        let parameters: Parameters=[
            "name":textFieldName.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!,
            ]

        //Sending http post request
        postAlamofire(URL: URL_USER_STUDY_REGISTER, params: parameters, VC: self)
        
    }

    @IBAction func photoBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "사진 추가", message: "방식을 선택해 주세요", preferredStyle: .actionSheet)
        
        let pick = UIAlertAction(title: "보관함에서 선택", style: .default) { (_) in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "카메라", style: .default) { (_) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = false
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        
        let cancel = UIAlertAction(title: "cancle", style: .cancel)
        
        alert.addAction(camera)
        alert.addAction(pick)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.originalImage = image
            self.photoViewLabel.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
