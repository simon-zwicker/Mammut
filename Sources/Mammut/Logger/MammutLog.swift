//
//  MammutLog.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

final class MammutLog {

    // MARK: - Properties
    var level: Loglevel = .none
    private let dateFormatter: DateFormatter = .init()
    private var request: URLRequest?
    private var start: Date = .init()
    private var end: Date = .init()

    private var currentTime: String {
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

    private var duration: String {
        let seconds = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        return "\(seconds) s"
    }

    // MARK: = MammutLog
    func log(_ req: URLRequest) {
        guard level != .none else { return }
        self.request = req
        self.start = .init()
        NSLog("--------------- [Mammut - Log Start] ---------------")
        mammutLogBasic()

        if level == .debugCurl {
            mammutLogCurl()
        }
    }

    func log(_ response: URLResponse, data: Data) {
        guard level != .none else { return }
        if let response = response as? HTTPURLResponse {
            mammutLogStatusCode(response)
        }

        if level == .debug || level == .debugCurl {
            mammutLogString("Response", "")
            NSLog(data.decodeUTF8)
        }

        self.end = .init()
        mammutLogString("Call Duration", duration)
        NSLog("--------------- [Mammut - Log End] ---------------")
    }


    // MARK: - Private Helpers
    private func mammutLogBasic() {
        mammutLogUrl()
        mammutLogHeaders()
        mammutLogBody()
    }

    private func mammutLogUrl() {
        guard let method = request?.httpMethod, let url = request?.url else { return }
        mammutLogString("Method", method)
        mammutLogString("URL", url.absoluteString)
    }

    private func mammutLogHeaders() {
        guard let headers = request?.allHTTPHeaderFields else { return }
        mammutLogString("Headers", "")
        headers.forEach({ NSLog("-------- \($0.key): \($0.value)") })
    }

    private func mammutLogBody() {
        guard let body = request?.httpBody?.encodeUTF8 else { return }
        mammutLogString("Body", "")
        print(body)
    }

    private func mammutLogStatusCode(_ response: HTTPURLResponse) {
        mammutLogString("StatusCode", response.statusCode.description)
    }

    private func mammutLogCurl() {
        guard let curl = request?.curl() else { return }
        mammutLogString("CurlCommand", curl)
    }

    private func mammutLogString(_ key: String, _ value: String) {
        NSLog("[\(currentTime)][Mammut][\(key)]: \(value)")
    }
}
