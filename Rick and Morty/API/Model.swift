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

// MARK: - RMLocationInfoModel
struct RMLocationInfoModel: Codable {
	let info: RMInfoModel?
	let results: [RMLocationModel]?
}

// MARK: - RMLocationModel
struct RMLocationModel: Codable {
	let id: Int?
	let name: String?
	let type: String?
	let dimension: String?
	let residents: [String?]
	let url: String?
	let created: String?
}

// MARK: - RMEpisodeInfoModel
struct RMEpisodeInfoModel: Codable {
	let info: RMInfoModel?
	let results: [RMEpisodeModel]?
}

// MARK: - RMEpisodeModel
struct RMEpisodeModel: Codable {
	let id: Int?
	let name: String?
	let airDate: String?
	let episode: String?
	let characters: [String?]
	let url: String?
	let created: String?

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case airDate = "air_date"
		case episode
		case characters
		case url
		case created
	}
}

