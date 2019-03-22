//
// StringCheckerViewController.swift 
// GSSwiftKit_Example 
// 
// Created by Linzy on 2019/3/22. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import UIKit
import Eureka
import GSSwiftKit

class StringCheckerViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "StringChecker"
        form +++ Section("")
            <<< TextRow(){ row in
                row.tag = "phone"
                row.title = "电话号码"
                row.value = "13500000000"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    
                    do{
                        
                        try self?.showAlertMessage(StringChecker.isMoblie(self?.form.values()["phone"] as? String))
                    }catch{
                        
                        self?.showAlertMessage(error.localizedDescription)
                    }
                })
            <<< TextRow(){ row in
                row.tag = "IDCard"
                row.title = "身份证号"
                row.value = "440111199000000000"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    do{
                        print(self?.form.values()["IDCard"] as? String)
                        try self?.showAlertMessage(StringChecker.isIDCard(self?.form.values()["IDCard"] as? String))
                    }catch{
                        
                        self?.showAlertMessage(error.localizedDescription)
                    }
                })
        
    }
    
    func showAlertMessage(_ Message: String) {
        let alert = UIAlertController(title: "提示", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
}
