//
//  File.swift
//  
//
//  Created by Simon Zwicker on 04.05.24.
//

import Foundation

enum DataEncoding {
    case boundary(String)
    case contentDisposition(params: String, filename: String)
    case contentType(String)

    var data: Data? {
        switch self {
        case .boundary(let string):
            "\r\n--\(string)\r\n".data(using: .utf8)

        case .contentDisposition(let params, let filename):
            "Content-Disposition: form-data; name=\"\(params)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)

        case .contentType(let string):
            "Content-Type: \(string)\r\n\r\n".data(using: .utf8)
        }
    }
}
