//
//  RickAndMortyTypeWithRequest.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 02.03.2023.
//

import UIKit

// FIXME: Удалить и переписать в сам сервис
// FIXME: Стоит ли исползовать паттерн Builder, который будет формировать запрос?
/// A type representing one of three possible request options: character, location, episode.
enum RickAndMortyTypeWithRequest: String {
    
    case character
    case location
    case episode
    
    var base: String {
        
        "https://rickandmortyapi.com"
    }
    
    var path: String {
        
        "/api/" + rawValue
    }
    
    var method: String {
        
        "GET"
    }
    
    /// Метод формирует запрос на основании выбраного типа.
    /// - Returns: URLRequest запрос.
    func getRequest() throws -> URLRequest {
        
        guard let base = URL(string: base) else {
            
            throw RickAndMortyError.invalidBase
        }
        
        guard let url = URL(string: path, relativeTo: base) else {
            
            throw RickAndMortyError.invalidPath
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            
            throw RickAndMortyError.canNotOpenURL
        }
        
        var request = URLRequest(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: 10
        )
        
        request.httpMethod = method
        
        return request
    }
}
