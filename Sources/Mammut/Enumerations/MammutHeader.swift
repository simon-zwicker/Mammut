//
//  MammutHeader.swift
//
//
//  Created by Simon Zwicker on 02.05.24.
//

public enum MammutHeader: Equatable {
    case cacheControl(String)
    case connection(String)
    case authorization(Authorization)
    case content(Content)
    case accept(Accept)

    var key: String {
        switch self {
        case .cacheControl: "Cache-Control"
        case .connection: "Connection"
        case .authorization: "Authorization"
        case .content(let content): content.key
        case .accept(let accept): accept.key
        }
    }

    var value: String {
        switch self {
        case .cacheControl(let string): string
        case .connection(let string): string
        case .authorization(let authorization): authorization.value
        case .content(let content): content.value
        case .accept(let accept): accept.value
        }
    }
}

public enum Authorization: Equatable {
    case basic(String)
    case bearer(String)

    var value: String {
        switch self {
        case .basic(let string): "Basic \(string)"
        case .bearer(let string): "Bearer \(string)"
        }
    }
}

public enum Content: Equatable {
    case length(Int)
    case type(String)

    var key: String {
        switch self {
        case .length: "Content-Length"
        case .type: "Content-Type"
        }
    }

    var value: String {
        switch self {
        case .length(let int): "\(int)"
        case .type(let string): string
        }
    }
}

public enum Accept: Equatable {
    case accept(String)
    case charset(String)
    case encoding(String)
    case language(String)

    var key: String {
        switch self {
        case .accept: "Accept"
        case .charset: "Accept-Charset"
        case .encoding: "Accept-Encoding"
        case .language: "Accept-Language"
        }
    }

    var value: String {
        switch self {
        case .accept(let string): string
        case .charset(let string): string
        case .encoding(let string): string
        case .language(let string): string
        }
    }
}
