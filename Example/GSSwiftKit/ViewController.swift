//
//  ViewController.swift
//  GSSwiftKit
//
//  Created by zoelam020@gmail.com on 03/22/2019.
//  Copyright (c) 2019 zoelam020@gmail.com. All rights reserved.
//

import UIKit
import Eureka

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "目录"
        form +++ Section("Tools")
            <<< ButtonRow(){
                $0.title = "StringChecker"
                }.onCellSelection({ [weak self](row, row1) in
                    self?.navigationController?.pushViewController(StringCheckerViewController(), animated: true)
                })
            +++ Section("Extensions")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

