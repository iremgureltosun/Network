//
//  File.swift
//
//
//  Created by Tosun, Irem on 25.10.2023.
//

import Combine
import Foundation

@available(macOS 10.15, *)
@available(iOS 13.0, *)
open class CoreNetworkService<T> where T: HTTPResponseProtocol {
    public typealias HTTPEntityType = T.Type
    let urlSession: URLSession
    private lazy var jsonDecoder: JSONDecoder = .init()
    var debugText: String = ""

    public init() {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    public func performRequest(urlRequest: URLRequest) throws -> AnyPublisher<T, Error> {
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse(HttpStatusCode.ClientError.badRequest)
                }
                guard HttpStatusCode.Success.range.contains(httpResponse.statusCode) else {
                    throw HTTPError.invalidResponse(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    print("Decoding error occured!")
                    switch decodingError {
                    case let .dataCorrupted(context):
                        self.debugText = "\(context)"
                    case let .keyNotFound(key, context):
                        self.debugText = "Key \(key) not found: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    case let .valueNotFound(value, context):
                        self.debugText = "Value \(value) not found: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    case let .typeMismatch(type, context):
                        self.debugText = "Type: \(type) mismatched: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    default: self.debugText = "\(error.localizedDescription)"
                    }
                    print(self.debugText)
                    return error
                } else {
                    // Handle other types of errors
                    return error
                }
            }.eraseToAnyPublisher()
    }
    
    public func performRequest(urlRequest: URLRequest) throws -> AnyPublisher<[T], Error> {
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse(HttpStatusCode.ClientError.badRequest)
                }
                guard HttpStatusCode.Success.range.contains(httpResponse.statusCode) else {
                    throw HTTPError.invalidResponse(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: [T].self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    print("Decoding error occured!")
                    switch decodingError {
                    case let .dataCorrupted(context):
                        self.debugText = "\(context)"
                    case let .keyNotFound(key, context):
                        self.debugText = "Key \(key) not found: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    case let .valueNotFound(value, context):
                        self.debugText = "Value \(value) not found: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    case let .typeMismatch(type, context):
                        self.debugText = "Type: \(type) mismatched: \(context.debugDescription) \n Coding path \(context.codingPath)"
                    default: self.debugText = "\(error.localizedDescription)"
                    }
                    print(self.debugText)
                    return error
                } else {
                    // Handle other types of errors
                    return error
                }
            }.eraseToAnyPublisher()
    }
}
