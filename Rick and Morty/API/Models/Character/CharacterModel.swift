//
//  RMCharacterModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct CharacterModel: Codable {
    
    let id: Int
    
    let name: String
    
    let status: String
    
    let species: String
    
    let type: String
    
    let gender: String
    
    let origin: CharacterOriginModel
    
    let location: CharacterLocationModel
    
    let image: String
    
    let episode: [String]
    
    let url: String
    
    let created: String
}
