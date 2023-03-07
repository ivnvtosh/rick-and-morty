//
//  RickAndMortyProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 04.03.2023.
//

import Foundation

protocol RickAndMortyProtocol {

	func getCharacters() async throws -> CharacterInfoModel
	func getCharacters(from page: String) async throws -> CharacterInfoModel
}
