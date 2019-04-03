//
// JSONViewController.swift 
// GSSwiftKit_Example 
// 
// Created by Linzy on 2019/4/3. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation
import Eureka
import GSSwiftKit

struct TestJSONBean : Codable {
    var name : String?
    var age : Int?
}

class JSONViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "JSON"
        form +++ Section("")
            <<< TextAreaRow(){ row in
                row.tag = "JSONString"
                row.title = "JSON String"
                row.value = ""
            }
            <<< TextAreaRow(){ row in
                row.tag = "Bean"
                row.title = "JSON Bean"
                row.value = ""
            }
            <<< ButtonRow(){
                $0.title = "Bean To JSON String"
                }.onCellSelection({ [weak self](row, row1) in
                    let testBean = TestJSONBean(name: "aaa", age: 12)
                    self?.form.setValues(["JSONString":JSONEncoder.toJSONString(testBean)])
                    self?.tableView.reloadData()
                })
            <<< ButtonRow(){
                $0.title = "JSON String To Bean"
                }.onCellSelection({ [weak self](row, row1) in
                    guard let str = self?.form.values()["JSONString"] as? String else{
                        self?.form.setValues(["localizeWithFormat":""])
                        return;
                    }
                    self?.form.setValues(["Bean":"\(JSONDecoder.formJson(str, to: TestJSONBean.self))"])
                    self?.tableView.reloadData()
                })
    }
    
    func showAlertMessage(_ Message: String) {
        let alert = UIAlertController(title: "提示", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
}
