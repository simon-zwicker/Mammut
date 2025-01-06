// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class Mammut {

    // MARK: - Properties
    static let mammutLog: MammutLog = .init()

    public var loglevel: Loglevel {
        get { Self.mammutLog.level }
        set { Self.mammutLog.level = newValue }
    }

    // MARK: - Initialization
    public init(
        components: URLComponents,
        timeout: TimeInterval? = nil,
        loglevel: Loglevel = .none
    ) {
        self.loglevel = loglevel
        MammutService.main.configuration(components, timeout)
    }

    public func request<T: Codable>(
        _ endpoint: Endpoint,
        error: Codable.Type,
        data: MammutData? = nil
	) async -> Result<T, MammutError> {
        await MammutService.main.request(endpoint, error: error, data: data)
    }
}
