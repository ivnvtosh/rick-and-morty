//
//  ImageError.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 02.03.2023.
//

/// A type representing an error value that can be thrown.
enum ImageError: Error {
    
    case invalidURL
    case failedToConvertResponse
    case statusCodeIsNot200(Int)
    case notInitializeImageFromData
}
