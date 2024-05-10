//
//  MammutService.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

import Foundation

final class MammutService: NSObject {

    // MARK: - Static Properties
    static let main: MammutService = .init()

    // MARK: - Properties
    private var components: URLComponents?
    private var timeout: TimeInterval?
    private var request: URLRequest?
    private var endpoint: Endpoint?
    private var data: MammutData?

    // MARK: - Service Configuration
    func configuration(_ components: URLComponents, _ timeout: TimeInterval?) {
        self.timeout = timeout
        self.components = components
    }

    func request<T: Codable>(_ endpoint: Endpoint, error: Codable.Type, data: MammutData? = nil) async -> Result<T, Error> {
        self.endpoint = endpoint
        self.data = data
        guard let req = try? await createReq() else { return .failure(MammutError.invalidUrl) }
        let session: URLSession = .init(configuration: .default, delegate: self, delegateQueue: .main)

        do {
            let (data, response) = try await session.data(for: req, delegate: nil)
            guard let response = response as? HTTPURLResponse else { return .failure(MammutError.noResponse) }

            Mammut.mammutLog.log(response, data: data)

            switch response.statusCode {
            case 200...299:
                guard let decoded = try? data.decode(T.self) else { return .failure(MammutError.decode) }
                return .success(decoded)

            case 401:
                guard let decoded = try? data.decode(error) else { return .failure(MammutError.decode) }
                return .failure(MammutError.unauthorized(decoded))

            case 404:
                guard let decoded = try? data.decode(error) else { return .failure(MammutError.decode) }
                return .failure(MammutError.noData(decoded))

            default:
                guard let decoded = try? data.decode(error) else { return .failure(MammutError.decode) }
                return .failure(MammutError.unexpectedStatusCode(decoded))
            }
        } catch {
            return .failure(MammutError.unknown)
        }
    }

    // MARK: - Helper Functions
    private func createReq() async throws -> URLRequest {
        guard let endpoint, let baseUrl = try? await endpointUrl() else { throw MammutError.invalidUrl }
        request = .init(url: baseUrl)

        requestBody()
        request?.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach({ request?.setValue($0.value, forHTTPHeaderField: $0.key) })

        guard let request else { throw MammutError.unknown }
        Mammut.mammutLog.log(request)
        return request
    }

    private func endpointUrl() async throws -> URL {
        guard var components, let endpoint else { throw MammutError.invalidUrl }

        if endpoint.parameters.isNotEmpty, endpoint.encoding == .url {
            components.queryItems = MammutUtils.urlEncoded(endpoint.parameters)
        }
        components.path += endpoint.path

        guard let baseUrl = components.url else { throw MammutError.invalidUrl }
        return baseUrl
    }

    private func requestBody() {
        guard let endpoint, endpoint.parameters.isNotEmpty else { return }
        switch endpoint.encoding {
        case .json:
            request?.httpBody = MammutUtils.jsonEncoded(endpoint.parameters)

        case .jsonToUrl:
            request?.httpBody = MammutUtils.jsonToUrlEncoded(endpoint.parameters)

        case .data:
            request?.httpBody = MammutUtils.dataEncoded(data)

        default:
            return
        }
    }
}

//MARK: - URLSessionDelegate
extension MammutService: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.serverTrust == nil {
            completionHandler(.useCredential, nil)
        }

        guard Mammut.insecureConnection, let trust: SecTrust = challenge.protectionSpace.serverTrust else { return }
        let credentials: URLCredential = .init(trust: trust)
        completionHandler(.useCredential, credentials)
    }
}
