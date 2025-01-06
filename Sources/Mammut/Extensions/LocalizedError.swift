//
//  LocalizedError.swift
//  Mammut
//
//  Created by Simon Zwicker on 06.01.25.
//

import Foundation

public extension LocalizedError {
	var complete: String {
		"""
		[Mammut Error]: \(self)
		[What happend?]: \(self.localizedDescription)
		[Reason]: \(self.failureReason ?? "")
		[Take Action]: \(self.recoverySuggestion ?? "")
		"""
	}
}
