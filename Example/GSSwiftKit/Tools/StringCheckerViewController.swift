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
                    guard let input = self?.form.values()["phone"] as? String else{
                        return
                    }
                   
                    do{
                        try self?.showAlertMessage(input.checkString(.isMoblie))
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
                        try self?.showAlertMessage(StringChecker.isIDCard(self?.form.values()["IDCard"] as? String))
                    }catch{
                        
                        self?.showAlertMessage(error.localizedDescription)
                    }
                })
            <<< TextRow(){ row in
                row.tag = "isLetterOrNumber"
                row.title = "字母或数字"
                row.value = "11111"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    do{
                        try self?.showAlertMessage(StringChecker.isLetterOrNumber(self?.form.values()["isLetterOrNumber"] as? String))
                    }catch{
                        
                        self?.showAlertMessage(error.localizedDescription)
                    }
                })
            <<< TextRow(){ row in
                row.tag = "isStrongPassword"
                row.title = "强密码"
                row.value = "aaAA11-"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    do{
                        try self?.showAlertMessage(StringChecker.isStrongPassword(self?.form.values()["isStrongPassword"] as? String))
                    }catch{
                        
                        self?.showAlertMessage(error.localizedDescription)
                    }
                })
            <<< TextRow(){ row in
                row.tag = "Emoji"
                row.title = "Emoji"
                row.value = "🍃"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    if StringChecker.isContainsEmoji(self?.form.values()["Emoji"] as? String){
                        self?.showAlertMessage("有")
                    }else{
                         self?.showAlertMessage("没有")
                    }
                })
            <<< TextRow(){ row in
                row.tag = "isIPAddress"
                row.title = "IP地址"
                row.value = "127.0.0.0"
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    do{
                        try self?.showAlertMessage(StringChecker.isIPAddress(self?.form.values()["isIPAddress"] as? String))
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
