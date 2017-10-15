//
//  PageVC.swift
//  Last
//
//  Created by 김지섭 on 2017. 6. 19..
//  Copyright © 2017년 JiseobKim. All rights reserved.
//

import UIKit

class SwitchMain: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: CustomSegment!
    @IBOutlet weak var contentView: UIView!
    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.initUI()
        segmentedControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)

        self.navigationItem.title = "최근 현황"
        

    }
    
    
    
    //Add 버튼 VC 연결
    @IBAction func Add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정보 추가", message: "추가 할 정보를 선택해 주세요", preferredStyle: .actionSheet)
        
        let addMaster = UIAlertAction(title: "스터디 수정", style: .default) {
            (_) in
            if let goMaster = self.storyboard?.instantiateViewController(withIdentifier: "AddMaster") {
                self.navigationController?.pushViewController(goMaster, animated: true)
            }
        }
        
        let addReport = UIAlertAction(title: "보고서 작성", style: .default) {
            (_) in
            if let goReport = self.storyboard?.instantiateViewController(withIdentifier: "AddReport") {
                self.navigationController?.pushViewController(goReport, animated: true)
            }
        }
        
        let addMember = UIAlertAction(title: "구성원 추가", style: .default) {
            (_) in
            if let goMember = self.storyboard?.instantiateViewController(withIdentifier: "AddMember") {
                self.navigationController?.pushViewController(goMember, animated: true)
            }
        }
        
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(addMaster)
        alert.addAction(addReport)
        alert.addAction(addMember)
        alert.addAction(cancel)
        alert.view.tintColor = UIColor(red: 251/255, green: 117/255, blue: 39/255, alpha: 1)
        
        self.present(alert, animated:true)
        
        
    }
    
    
    //Segment
    
    var currentViewController : UIViewController?
    
    lazy var firstChildVC : UIViewController? = {
        let firstChildVC = self.storyboard?.instantiateViewController(withIdentifier: "MainRecent")
        return firstChildVC
    }()
    
    
    lazy var secondChildVC : UIViewController? = {
        let firstChildVC = self.storyboard?.instantiateViewController(withIdentifier: "MainLog")
        return firstChildVC
    }()
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildVC
        default:
            return nil
        }
        
        return vc
    }
    
    
    
    
   
    
    
    
}


