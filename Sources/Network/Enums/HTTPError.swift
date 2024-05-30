//
//  File.swift
//
//
//  Created by Tosun, Irem on 25.10.2023.
//

import Foundation

public enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse(Int)
    case notFoundResponse
    case invalidRequest
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .notFoundResponse:
            return "Not found"
        case let .statusCode(int):
            return String(int)
        case .invalidRequest:
            return "Invalid request"
        }
    }
}
