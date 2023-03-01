//
//  RMCharacterStatusModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMCharacterStatusModel
enum RMCharacterStatusModel: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    case none = ""
}
