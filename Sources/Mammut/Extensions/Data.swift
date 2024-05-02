//
//  Data.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

public extension Data {
    func decode<T: Codable>(_ type: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }

    var encodeUTF8: String? {
        String(data: self, encoding: .utf8)
    }

    var decodeUTF8: String {
        String(decoding: self, as: UTF8.self)
    }
}
