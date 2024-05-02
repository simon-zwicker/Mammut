//
//  File.swift
//  
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

struct MammutUtils {
    static func urlEncoded(_ params: [String: Any]) -> [URLQueryItem] {
        params.compactMap({ URLQueryItem(name: $0.key, value: $0.value as? String) })
    }

    static func jsonEncoded(_ object: [String: Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: object, options: [])
    }

    static func jsonToUrlEncoded(_ object: [String: Any]) -> Data? {
        var string = ""
        for (index, param) in object.enumerated() {
            string += index > 0 ? "&": ""
            string += "\(param.key)=\(param.value)"
        }
        return string.data(using: .utf8)
    }
}
