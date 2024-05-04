//
//  File.swift
//  
//
//  Created by Simon Zwicker on 03.05.24.
//

import Foundation

public struct MammutData {
    let fileName: String
    let type: DataType
    let data: Data
    let parameter: String
    let boundary: String

    public init(fileName: String, type: DataType, data: Data, parameter: String, boundary: String) {
        self.fileName = fileName
        self.type = type
        self.data = data
        self.parameter = parameter
        self.boundary = boundary
    }
}
