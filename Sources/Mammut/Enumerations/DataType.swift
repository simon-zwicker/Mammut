//
//  DataType.swift
//
//
//  Created by Simon Zwicker on 04.05.24.
//

public enum DataType {
    case jpeg
    case pdf

    var contentType: String {
        switch self {
        case .jpeg: "image/jpeg"
        case .pdf: "application/pdf"
        }
    }
}
