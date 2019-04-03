//
// JSONDecoder+Decode.swift 
// GSSwiftKit 
// 
// Created by Linzy on 2019/3/22. 
// Copyright © 2019 Gosuncn. All rights reserved.
// 


import Foundation
public extension JSONDecoder {
    // JSON-> 实体类
    static func formJson<T: Codable>(_ string: String, to type: T.Type) -> T? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        return formJson(data, to: type.self)
    }
    
    // JSON-> 实体类
    static func formJson<T: Codable>(_ json: [String: Any], to type: T.Type) -> T? {
       do{
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return formJson(data, to: type)
        }catch{
            return nil
        }
    }

    // JSON-> 实体类
    static func formJson<T: Codable>(_ data: Data, to type: T.Type) -> T? {
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            return nil
        }
    }
}
