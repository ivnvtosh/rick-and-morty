//
//  CharacterInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct CharacterInfoModel: Codable {
    
    let info: InfoModel
    
    let results: [CharacterModel] 
}
