//
//  File.swift
//
//
//  Created by Tosun, Irem on 25.10.2023.
//

import Foundation

public enum EndPointError: Error {
    case urlFailure
}

public enum HttpMethod {
    case get
    case put
    case post
    case delete
    case head

    public var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .head: return "HEAD"
        }
    }
}
