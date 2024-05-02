//
//  MammutError.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

public enum MammutError: Error {
    case decode
    case invalidUrl
    case noResponse
    case noData(Codable)
    case unauthorized(Codable)
    case unexpectedStatusCode(Codable)
    case unknown
}
