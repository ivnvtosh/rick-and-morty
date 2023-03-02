//
//  RMCharacterStatusModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// FIXME: Порядок важен от чего enum основывается?
enum RMCharacterStatusModel: String, Codable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    case none = ""
}
