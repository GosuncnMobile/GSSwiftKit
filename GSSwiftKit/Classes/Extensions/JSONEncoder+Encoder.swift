//
// JSONEncoder+Encoder.swift 
// GSSwiftKit 
// 
// Created by Linzy on 2019/3/22. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation
public extension JSONEncoder {
    
    //实体类 -> JSON String
    static func toJSONString<T: Encodable>(_ entity: T) -> String? {
        guard let encodedData = try? JSONEncoder().encode(entity) else {
            return nil
        }
        return String(data: encodedData, encoding: .utf8)
    }
    
     //实体类 -> JSON Dictionary
    static func toJSONDictionary<T: Encodable>(_ entity: T) -> [String : Any]? {
        guard let encodedData = try? JSONEncoder().encode(entity) else {
            return nil
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
    
}

