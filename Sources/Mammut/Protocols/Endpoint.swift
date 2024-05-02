//
//  Endpoint.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: Method { get }
    var headers: [Header] { get }
    var parameters: [String: Any] { get }
    var encoding: Encoding { get }
}
