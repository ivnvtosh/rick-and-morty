//
//  RickAndMortyError.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 02.03.2023.
//

/// A type representing an error value that can be thrown.
enum RickAndMortyError: Error {
    
    case invalidBase
    case invalidPath
    case invalidURL
    case canNotOpenURL
    case noResponse
    case failedToConvertResponse
    case statusCodeIsNot200(Int)
    case noData
    case failedToDecode(String)
}

// FIXME: Нужно ли как-то организовать папку API?
