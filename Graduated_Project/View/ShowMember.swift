//
//  ShowMember.swift
//  Graduated_Project
//
//  Created by 김지섭 on 2017. 9. 27..
//  Copyright © 2017년 JS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ShowMember: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var memberObject : [MemberInfo] = []
    var nameArray : [String] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request(URL_GET_MEMBER).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                
                let dataArray = data as! NSArray
                // Add object into memberObject[MemberInfo]
                
                for row in dataArray {
                    let objToDic = row as! NSDictionary
                    
                    
                    // NS -> JSON -> use decoadable -> append
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: objToDic, options: .prettyPrinted)
                        self.memberObject.append(try JSONDecoder().decode(MemberInfo.self, from: jsonData))
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
                
                //collectionView reload
                self.collectionView?.reloadData()
                
            case .failure(let e):
                print(e.localizedDescription)
                print("line:52")
            }
        } // end Alamofire
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        memberObject = []
        nameArray = []
    }
    
    
    override func viewDidLoad() {
        
        
        
        let width = collectionView!.frame.width
        let height = collectionView!.frame.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width/3, height: height/10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        
        
    }

}

extension ShowMember {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberObject.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCell", for: indexPath) as! ShowMemberCell
        cell.nameLabel.text = memberObject[indexPath.row].name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = memberObject[indexPath.row]
        performSegue(withIdentifier: "MemberInfo", sender: item)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberInfo" {
            if let destination = segue.destination as? ShowMemberInfo{
                if let memberStr = sender as? MemberInfo{
                    destination.getValue = memberStr
  
                }
            }
        }
    }
}
