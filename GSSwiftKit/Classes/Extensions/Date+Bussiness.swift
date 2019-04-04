//
// Date+Bussiness.swift 
// GSSwiftKit 
//
// 业务时间戳工具
// Created by Linzy on 2019/4/4. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation

public extension Date {
    
    // 返回当前时间戳,格式与服务端约定
    var currentGSDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        return dateFormatter.string(from: Date())
    }
    
    
    var currentGSDateLogString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:SSS")
        return dateFormatter.string(from: Date())
    }
    
}

public enum StringToDateType{
    // 时间戳
    case timeStamp
    // 业务时间文本
    case GSDateString
}

public extension String {
    
    func GS2Date(_ from : StringToDateType = .timeStamp) -> Date?{
        switch from {
        case .timeStamp:
            guard let timeIntervalSince1970  = TimeInterval(self) else {
                return nil
            }
            return Date.init(timeIntervalSince1970: timeIntervalSince1970)
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
            return dateFormatter.date(from: self)
        }
    }
}
