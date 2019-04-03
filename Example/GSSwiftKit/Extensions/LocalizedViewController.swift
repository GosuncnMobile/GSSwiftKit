//
// LocalizedViewController.swift 
// GSSwiftKit_Example 
// 
// Created by Linzy on 2019/4/3. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation
import Eureka
import GSSwiftKit

class LocalizedViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Localized String"
        form +++ Section("")
            <<< TextRow(){ row in
                row.tag = "String"
                row.title = "String"
                row.value = "Hello"
            }
            <<< TextRow(){ row in
                row.tag = "Localized"
                row.title = "Localized"
                row.value = ""
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    guard let str = self?.form.values()["String"] as? String else{
                        self?.form.setValues(["Localized":""])
                        return;
                    }
                    print(str)
                    let localizedStr = NSLocalizedString(str, tableName: nil, bundle: Bundle.main, value: "", comment: "");
                    print(localizedStr)
                    self?.form.setValues(["Localized":str.localized])
                    self?.tableView.reloadData()
                })
            <<< TextRow(){ row in
                row.tag = "input"
                row.title = "Input"
                row.value = "center"
            }
            <<< TextRow(){ row in
                row.tag = "localizeWithFormat"
                row.title = "Format"
                row.value = ""
            }
            <<< ButtonRow(){
                $0.title = "Check"
                }.onCellSelection({ [weak self](row, row1) in
                    guard let str = self?.form.values()["input"] as? String else{
                        self?.form.setValues(["localizeWithFormat":""])
                        return;
                    }
                    print(str)
                    self?.form.setValues(["localizeWithFormat":"localizeWithFormat".localizeWithFormat(str)])
                    self?.tableView.reloadData()
                })
    }
    
    func showAlertMessage(_ Message: String) {
        let alert = UIAlertController(title: "提示", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
}
