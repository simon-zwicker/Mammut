//
//  String.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

extension String {
    var curlMethod: Bool {
        self != Method.get.rawValue && self != Method.head.rawValue
    }
}
