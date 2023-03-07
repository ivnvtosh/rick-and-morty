//
//  HTTPMethod.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 06.03.2023.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
