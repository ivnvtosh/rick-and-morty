//
//  RMCharacterInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct RMCharacterInfoModel: Codable {
    
    let info: RMInfoModel?
    
    let results: [RMCharacterModel]?
}
