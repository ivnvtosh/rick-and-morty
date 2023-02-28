//
//  RickAndMortyService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022.
//

import UIKit

/// A type representing an error value that can be thrown.
enum RickAndMortyError: Error {
	
	case invalidBase
	case invalidPath
	case canNotOpenURL
	case noResponse
	case failedToConvertResponse
	case statusCodeIsNot200(Int)
	case noData
	case failedToDecode(String)
}

/// A type representing one of three possible request options: character, location, episode.
enum RickAndMortyTypeWithRequest: String {
	
	case character
	case location
	case episode
	
	var base: String {
		"https://rickandmortyapi.com"
	}
	
	var path: String {
		"/api/" + self.rawValue
	}
	
	var method: String {
		"GET"
	}
	
	var request: Result<URLRequest, Error> {
		
		guard let base = URL(string: base) else {
			
			return .failure(RickAndMortyError.invalidBase)
		}
		
		guard let url = URL(string: path, relativeTo: base) else {
			
			return .failure(RickAndMortyError.invalidPath)
		}
		
		guard UIApplication.shared.canOpenURL(url) else {
			
			return .failure(RickAndMortyError.canNotOpenURL)
		}
		
		var request = URLRequest(
			url: url,
			cachePolicy: .returnCacheDataElseLoad,
			timeoutInterval: 10
		)
		
		request.httpMethod = method
		
		return .success(request)
	}
}

/// Это сервис для получения актуальной информации по
/// персонажам, локациям и эпизодам по мультсериалу "Рик и Морти"
class RickAndMortyService {
	
	
	/// Универсальный метод, который по запросу загружает JSON и декодирует его в модель
	/// - Parameters:
	///     - T Decodable: Модель, которая будет получно из JSON
	///     - with request URLRequest: Сформированный запрос
	/// - Returns: Возвращает модель
	private func dataTask<T: Decodable>(with request: URLRequest) async throws -> T { // FIXME: where?
		
		let (data, response) = try await URLSession.shared.data(for: request)
		
		guard let response = response as? HTTPURLResponse else {
			
			throw RickAndMortyError.failedToConvertResponse
		}
		
		if response.statusCode != 200 {
			
			throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
		}
		
		do {
			let decoder = JSONDecoder()
			let object = try decoder.decode(T.self, from: data)
			
			return object
		}
		
		catch {
			let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
			let error = RickAndMortyError.failedToDecode(message)
			
			throw error
		}
	}
	
	/// Универсальный метод, который формирует один из трех возможных вариантов запрос и затем выполяняет его
	/// - Parameters:
	///     - type RickAndMortyTypeWithRequest: enum, который составляет
	///       один из трех возможных вариантов запроса: character, location, episode
	/// - Returns: Возвращает одну из моделей: RMCharacterInfoModel, RMLocationInfoModel, RMEpisodeInfoModel
	private func dataTask<T: Decodable>(type: RickAndMortyTypeWithRequest) async throws -> T {
		
		let result = type.request
		switch result {
			
		case .success(let request):
			return try await dataTask(with: request)
			
		case .failure(let error):
			throw error
		}
	}
	
	/// Универсальный метод, который формирует запроc по готовой ссылке и затем выполяняет его
	/// - Parameters:
	///     - with url URL: Ссылка для загрузки
	/// - Returns: Возвращает модель
	private func dataTask<T: Decodable>(with url: URL) async throws -> T {
		
		let request = URLRequest(url: url)
		return try await dataTask(with: request)
	}

	// MARK: - Characters

	/// Метод, который выполняет сетевой запрос, для получения актуальной ифнормации по персонажам
	/// - Returns: Возвращает модель, которая содержит массив первых десяти персонажей
	///            и курсор
	public func getCharacters() async throws -> RMCharacterInfoModel {
		
        return try await dataTask(type: .character)
	}

	/// Метод, который выполняет сетевой запрос, для получения актуальной ифнормации по персонажам
	/// - Returns: Возвращает модель, которая содержит массив `следующих` десяти персонажей
	///            и информацию о текущем местоположении курсора
	public func getCharacters(page: String) async throws -> RMCharacterInfoModel {
		
//		guard let url = URL(string: page) else { return }
        let url = URL(string: page)!
        return try await dataTask(with: url)
	}

//	// MARK: - Locations
//
//	public func getLocations(completion: @escaping (Result<RMLocationInfoModel, Error>) -> Void) {
	
//		dataTask(type: .location, completion: completion)
//	}
//
//	public func getLocations(page: String, completion: @escaping (Result<RMLocationInfoModel, Error>) -> Void) {
	
//		guard let url = URL(string: page) else { return }
//		dataTask(with: url, completion: completion)
//	}
//
//	// MARK: - Episodes
//
//	public func getEpisodes(completion: @escaping (Result<RMEpisodeInfoModel, Error>) -> Void) {
	
//		dataTask(type: .episode, completion: completion)
//	}
//
//	public func getEpisodes(page: String, completion: @escaping (Result<RMEpisodeInfoModel, Error>) -> Void) {
	
//		guard let url = URL(string: page) else { return }
//		dataTask(with: url, completion: completion)
//	}
}

