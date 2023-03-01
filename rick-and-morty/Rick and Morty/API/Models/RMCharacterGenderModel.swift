//
//  RMCharacterGenderModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMCharacterGenderModel
enum RMCharacterGenderModel: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown
    case none = ""
}
