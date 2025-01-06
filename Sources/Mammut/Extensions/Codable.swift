//
//  Codable.swift
//  Mammut
//
//  Created by Simon Zwicker on 06.01.25.
//

import Foundation

public extension Encodable {
	var dictionary: [String: Any] {
		guard
			let data = try? JSONEncoder().encode(self),
			let object = try? JSONSerialization.jsonObject(with: data, options: []),
			let dict = object as? [String: Any]
		else {
			return [:]
		}

		return dict
	}
}
