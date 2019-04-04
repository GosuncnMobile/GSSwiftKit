//
// NSMutableAttributedString+Focus.swift 
// GSSwiftKit 
// 
// Created by Linzy on 2019/4/4. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation


public extension NSMutableAttributedString {
    //最常用的富文本就是在一段话里高亮显示几个字
    convenience init(input : String, color : UIColor = UIColor.red, location : Int, length : Int){
        self.init(string: input);
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange.init(location:location, length: length))
        self.addAttribute(NSAttributedString.Key.expansion, value: 1, range: NSRange.init(location:location, length: length))
    }
}
