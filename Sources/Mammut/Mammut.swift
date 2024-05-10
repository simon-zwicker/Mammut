// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class Mammut {

    // MARK: - Properties
    static let mammutLog: MammutLog = .init()
    static var insecureConnection: Bool = false

    public var loglevel: Loglevel {
        get { Self.mammutLog.level }
        set { Self.mammutLog.level = newValue }
    }

    public var insecure: Bool {
        get { Self.insecureConnection }
        set { Self.insecureConnection = newValue }
    }

    // MARK: - Initialization
    public init(
        components: URLComponents,
        timout: TimeInterval? = nil,
        loglevel: Loglevel = .none
    ) {
        self.loglevel = loglevel
    }

    public func request<T: Codable>(
        _ endpoint: Endpoint,
        error: Codable.Type,
        data: MammutData? = nil
    ) async -> Result<T, Error> {
        await MammutService.main.request(endpoint, error: error, data: data)
    }
}
