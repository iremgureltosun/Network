//
//  File.swift
//
//
//  Created by Tosun, Irem on 25.10.2023.
//

import Foundation

public protocol HTTPResponseProtocol: Codable {
    associatedtype HTTPEntityType
}
