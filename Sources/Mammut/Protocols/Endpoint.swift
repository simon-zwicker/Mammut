//
//  Endpoint.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: MammutMethod { get }
    var headers: [MammutHeader] { get }
    var parameters: [String: Any] { get }
	var customParameters: [String: Any] { get }
    var encoding: Encoding { get }
}
