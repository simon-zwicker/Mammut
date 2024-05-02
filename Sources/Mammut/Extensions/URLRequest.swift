//
//  URLRequest.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

extension URLRequest {
    public func curl() -> String {
        guard let url else { return "" }
        var command = ["curl \"\(url.absoluteString)\""]

        if let httpMethod, httpMethod.curlMethod {
            command.append(" -x \(httpMethod)")
        }

        allHTTPHeaderFields?.forEach({
            command.append(" -H '\($0.key): \($0.value)'")
        })

        if let httpBody, let body = httpBody.encodeUTF8 {
            command.append(" -d \(body)")
        }

        return command.joined()
    }
}
