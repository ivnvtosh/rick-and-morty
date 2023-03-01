//
//  RMCharacterInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMCharacterInfoModel
struct RMCharacterInfoModel: Codable {
    let info: RMInfoModel?
    let results: [RMCharacterModel]?
}
