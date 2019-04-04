//
// String+Localized.swift 
// GSSwiftKit 
// 
// Created by Linzy on 2019/4/3. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizeWithFormat(_ arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
}
