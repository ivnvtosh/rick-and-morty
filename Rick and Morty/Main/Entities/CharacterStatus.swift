//
//  CharacterStatus.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

enum CharacterStatus: String, Codable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    case none = ""
}
