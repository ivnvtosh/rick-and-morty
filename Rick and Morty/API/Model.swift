//
//  Model.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022.
//

import Foundation

// MARK: - RMCharacterFilter
struct RMCharacterFilter {
	let name: String?
	let status: String?
	let species: String?
	let type: String?
	let gender: String?
	let query: String?
}

// MARK: - RMCharacterInfoModel
struct RMCharacterInfoModel: Codable {
	let info: RMInfoModel?
	let results: [RMCharacterModel]?
}

// MARK: - RMInfoModel
struct RMInfoModel: Codable {
	let count: Int?
	let pages: Int?
	let next: String?
	let prev: String?
}

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

// MARK: - RMCharacterOriginModel
struct RMCharacterOriginModel: Codable {
	let name: String?
	let url: String?
}

// MARK: - RMCharacterLocationModel
struct RMCharacterLocationModel: Codable {
	let name: String?
	let url: String?
}

// MARK: - RMCharacterGenderModel
enum RMCharacterGenderModel: String, Codable {
	case female = "Female"
	case male = "Male"
	case genderless = "Genderless"
	case unknown
	case none = ""
}

// MARK: - RMCharacterStatusModel
enum RMCharacterStatusModel: String, Codable {
	case alive = "Alive"
	case dead = "Dead"
	case unknown
	case none = ""
}

