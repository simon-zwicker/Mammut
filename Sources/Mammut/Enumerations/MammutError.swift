//
//  MammutError.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

public enum MammutError: Error {
	case decode
	case invalidUrl
	case noResponse
	case noData(Codable)
	case unauthorized(Codable)
	case unexpectedStatusCode(Codable)
	case unknown
}

extension MammutError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .decode:
			return NSLocalizedString(
				"Decoding failed. The data received from the server could not be decoded into the expected format.",
				comment: "Error when decoding a response"
			)
		case .invalidUrl:
			return NSLocalizedString(
				"Invalid URL. The requested endpoint could not be reached due to a malformed URL.",
				comment: "Error when the URL is invalid"
			)
		case .noResponse:
			return NSLocalizedString(
				"No response from the server. Please check your internet connection or try again later.",
				comment: "Error when no response is received"
			)
		case .noData(let context):
			return NSLocalizedString(
				"No data received. The server responded, but the body is empty. Context: \(context)",
				comment: "Error when the server response has no data"
			)
		case .unauthorized(let context):
			return NSLocalizedString(
				"Unauthorized access. Please check your credentials or permissions. Context: \(context)",
				comment: "Error for 401 Unauthorized"
			)
		case .unexpectedStatusCode(let context):
			return NSLocalizedString(
				"Unexpected status code received. Please contact support if the issue persists. Context: \(context)",
				comment: "Error for unexpected status codes"
			)
		case .unknown:
			return NSLocalizedString(
				"An unknown error occurred. Please try again or contact support.",
				comment: "Generic error for unknown issues"
			)
		}
	}

	public var recoverySuggestion: String? {
		switch self {
		case .decode:
			return NSLocalizedString(
				"Ensure the data format matches the expected structure.",
				comment: "Suggestion for decode error"
			)
		case .invalidUrl:
			return NSLocalizedString(
				"Check if the URL is correctly formatted and try again.",
				comment: "Suggestion for invalid URL error"
			)
		case .noResponse:
			return NSLocalizedString(
				"Check your internet connection or the server's status.",
				comment: "Suggestion for no response error"
			)
		case .noData:
			return NSLocalizedString(
				"Verify the server is returning the correct data format.",
				comment: "Suggestion for no data error"
			)
		case .unauthorized:
			return NSLocalizedString(
				"Ensure your credentials are correct and you have access to this resource.",
				comment: "Suggestion for unauthorized error"
			)
		case .unexpectedStatusCode:
			return NSLocalizedString(
				"Check the server logs or contact support for help.",
				comment: "Suggestion for unexpected status code error"
			)
		case .unknown:
			return NSLocalizedString(
				"Try restarting the app or contact support for assistance.",
				comment: "Suggestion for unknown error"
			)
		}
	}

	public var failureReason: String? {
		switch self {
		case .decode:
			return NSLocalizedString(
				"The response data format did not match the expected format.",
				comment: "Reason for decode error"
			)
		case .invalidUrl:
			return NSLocalizedString(
				"The URL was malformed or contained invalid characters.",
				comment: "Reason for invalid URL error"
			)
		case .noResponse:
			return NSLocalizedString(
				"The server did not respond within the expected timeframe.",
				comment: "Reason for no response error"
			)
		case .noData:
			return NSLocalizedString(
				"The server returned an empty response body.",
				comment: "Reason for no data error"
			)
		case .unauthorized:
			return NSLocalizedString(
				"The request lacked valid authentication credentials.",
				comment: "Reason for unauthorized error"
			)
		case .unexpectedStatusCode:
			return NSLocalizedString(
				"The server returned a status code not handled by the application.",
				comment: "Reason for unexpected status code error"
			)
		case .unknown:
			return NSLocalizedString(
				"An error occurred that does not match any known cases.",
				comment: "Reason for unknown error"
			)
		}
	}
}
