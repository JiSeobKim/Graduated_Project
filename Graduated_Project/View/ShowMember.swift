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

class ShowMember: UICollectionViewController {
    
    var memberObject : [Member_Info] = []
    var nameArray : [String] = []
    var URL = "http://222.107.27.68:5123/swift/graduate/getMember.php"
    var test = true
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    
    override func viewDidLoad() {
        Alamofire.request(URL).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                
                let dataArray = data as! NSArray
                // Add object into memberObject[Member_Info]
                
                for row in dataArray {
                    let objToDic = row as! NSDictionary
                    
                    // NS -> JSON -> use decoadable -> append
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: objToDic, options: .prettyPrinted)
                        self.memberObject.append(try JSONDecoder().decode(Member_Info.self, from: jsonData))
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
                
                //collectionView reload
                self.collectionView?.reloadData()
                
            case .failure(let e):
                print(e.localizedDescription)
            }
        } // end Alamofire
    }
    
    
    
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
                if let memberStr = sender as? Member_Info{
                    destination.getValue = memberStr
                }
            }
        }
    }
    
    
        

        
    
    
    
    
    
    
    
}
