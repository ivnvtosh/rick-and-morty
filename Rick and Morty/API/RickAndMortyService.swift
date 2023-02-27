//
//  RickAndMortyService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022.
//

import UIKit

enum RMClientError: Error {
	case invalidBase
	case invalidPath
	case canNotOpenURL
	case noResponse
	case failedToConvertResponse
	case statusCodeIsNot200(Int)
	case noData
	case failedToDecode(String)
}

enum RMClientType: String {
	case character
	case location
	case episode

	var base: String {
		return "https://rickandmortyapi.com"
	}

	var path: String {
		return "/api/" + self.rawValue
	}

	var method: String {
		return "GET"
	}

	var request: Result<URLRequest, Error> {
		guard let base = URL(string: base) else {
			return .failure(RMClientError.invalidBase)
		}

		guard let url = URL(string: path, relativeTo: base) else {
			return .failure(RMClientError.invalidPath)
		}

		guard UIApplication.shared.canOpenURL(url) else {
			return .failure(RMClientError.canNotOpenURL)
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

class RickAndMortyService {

	private func dataTask<T: Decodable>(with request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw RMClientError.failedToConvertResponse
        }
        
        if response.statusCode != 200 {
            throw RMClientError.statusCodeIsNot200(response.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            
            return object
        }
        
        catch {
            let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
            let error = RMClientError.failedToDecode(message)
            
            throw error
        }
	}
    
    /// Это метод который
    /// type:RMClientType енам в котором
	private func dataTask<T: Decodable>(type: RMClientType) async throws -> T {
		let result = type.request
		switch result {
		case .success(let request):
            return try await dataTask(with: request)
		case .failure(let error):
            throw error
		}
	}

	private func dataTask<T: Decodable>(with url: URL) async throws -> T {
		let request = URLRequest(url: url)
		return try await dataTask(with: request)
	}

	// MARK: - Characters

	public func getCharacters() async throws -> RMCharacterInfoModel {
        return try await dataTask(type: .character)
	}

	public func getCharacters(page: String) async throws -> RMCharacterInfoModel {
//		guard let url = URL(string: page) else { return }
        let url = URL(string: page)!
        return try await dataTask(with: url)
	}
//
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

