//
// StringChecker.swift 
// GSSwiftKit_Example 
//
// String的各种校验
// Created by Linzy on 2019/3/20. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation
public enum StringCheckerType{
    case isMoblie
    case isIDCard
    case isLetterOrNumber
    case isIPAddress
}

public enum StringCheckerError : Error {
    case emptyError(_ message:String)
    case FormatError(_ message:String)
}

extension StringCheckerError : LocalizedError {
    public var errorDescription : String? {
        switch self {
        case .emptyError(message: let message):
            return message
        case .FormatError(message: let message):
            return message
        default:
            return "未知错误"
        }
    }
}

public extension String {
    func checkString(_ type : StringCheckerType) throws -> String{
        return try StringChecker.checkString(self, check: type)
    }
}

public struct StringChecker {
    public static func checkString(_ input : String?, check : StringCheckerType) throws -> String {
        switch check {
        case .isMoblie:
            return try isMoblie(input)
        case .isIDCard:
            return try isIDCard(input)
        case .isLetterOrNumber:
            return try isLetterOrNumber(input)
        case .isIPAddress:
            return try isIPAddress(input)
        default:
            return ""
        }
    }
    
    public static func isEmpty(_ input : String?) -> Bool{
        guard let str = input,
        str.trimmingCharacters(in: .whitespaces).count > 0
        else {
            return false
        }
        return true;
    }
    
    public static func isMoblie(_ input : String?) throws -> String {
        guard let input = input else {
            throw StringCheckerError.emptyError("手机号不能为空")
        }
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        guard phoneTest.evaluate(with: input) else {
            throw StringCheckerError.FormatError("手机号格式不正确")
        }
        return input
    }
    
    public static func isIPAddress(_ input : String?) throws -> String {
        guard let input = input else {
            throw StringCheckerError.emptyError("IP地址为空")
        }
        let regexrStr: String = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        let test = NSPredicate(format: "SELF MATCHES %@", regexrStr)
        guard test.evaluate(with: input) else {
            throw StringCheckerError.FormatError("IP地址格式不正确")
        }
        return input
    }
    
    //只包含字母和数字,例如用户和密码
    public static func isLetterOrNumber(_ input : String?) throws -> String{
        guard let input = input else {
            throw StringCheckerError.emptyError("不能为空")
        }
        let regex: String = "^[A-Za-z0-9]+$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        guard test.evaluate(with: input) else {
            throw StringCheckerError.FormatError("只能为英文或数字")
        }
        return input
    }
    
    //强密码,字数要求由业务决定
    //要求密码包括大小写字母数字以及特殊字符四种字符
    public static func isStrongPassword(_ input : String?) throws -> String{
        guard let input = input else {
            throw StringCheckerError.emptyError("不能为空")
        }
        if(input.count !=  input.data(using: .utf8)?.count){
            throw StringCheckerError.FormatError("密码包含不合法字符")
        }
        let regex: String = "^(?=.*?[A-Z]+)(?=(.*[a-z])+)(?=(.*[\\d])+)(?=(.*[\\W])+)(?!.*\\s).{4,}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        guard test.evaluate(with: input) else {
            throw StringCheckerError.FormatError("密码要求包括大小写字母数字以及特殊字符")
        }
        return input
    }
    
    public static func isIDCard(_ input : String?) throws -> String{
        guard let IDStr = input else {
            throw StringCheckerError.emptyError("身份证号不能为空")
        }
        guard IDStr.count == 15 || IDStr.count == 18 else {
            throw StringCheckerError.FormatError("身份证号码长度应该为15位或18位")
        }
        
        let IDCardRegex: String = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let IDCardTest = NSPredicate(format: "SELF MATCHES %@", IDCardRegex)
        guard IDCardTest.evaluate(with: IDStr) else {
            throw StringCheckerError.FormatError("身份证号格式不正确")
        }
        
        let birthdayStr = IDStr[IDStr.index(IDStr.startIndex, offsetBy: 6)..<IDStr.index(IDStr.startIndex, offsetBy: 14)]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let birthday = formatter.date(from: String(birthdayStr)),
            birthday.timeIntervalSinceNow  < 0,
            abs(birthday.timeIntervalSinceNow ) < 150*365*24*60*50
            else{
                throw StringCheckerError.FormatError("身份证号出生日期无效")
        }
        
        
        let areaRegex: String = "(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)"
        
        let areaTest = NSPredicate(format: "SELF MATCHES %@", areaRegex)
        let areaStr = IDStr[IDStr.index(IDStr.startIndex, offsetBy: 0)..<IDStr.index(IDStr.startIndex, offsetBy: 2)]
        guard areaTest.evaluate(with: areaStr) else {
            throw StringCheckerError.FormatError("区域编号不正确")
        }
        
        if (IDStr.count == 18){
            let factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ]
            let parity = [ "1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2" ]
            let code = IDStr[IDStr.index(before: IDStr.endIndex)]
            var sum = 0
            for i in 0..<17{
                sum += (Int(String(IDStr[IDStr.index(IDStr.startIndex, offsetBy: i)])) ?? 0) * factor[i]
            }
            guard parity[sum % 11] == String(code) else{
                throw StringCheckerError.FormatError("身份证号无效")
            }
            
        }
        
        return IDStr
    }
    
    public static func isContainsEmoji(_ input : String?) -> Bool{
        guard let input = input else {
            return false
        }
        for scalar in input.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
}
