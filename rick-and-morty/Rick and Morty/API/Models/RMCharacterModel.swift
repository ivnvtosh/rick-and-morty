//
//  RMCharacterModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMCharacterModel
struct RMCharacterModel: Codable {
    let id: Int?
    let name: String?
    let status: RMCharacterStatusModel?
    let species: String?
    let type: String?
    let gender: RMCharacterGenderModel?
    let origin: RMCharacterOriginModel?
    let location: RMCharacterLocationModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}
