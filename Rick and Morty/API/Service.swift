//
//  Service.swift
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

class RMClient {

	private func dataTask<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}

			guard let response = response else {
				completion(.failure(RMClientError.noResponse))
				return
			}

			guard let response = response as? HTTPURLResponse else {
				completion(.failure(RMClientError.failedToConvertResponse))
				return
			}

			if response.statusCode != 200 {
				completion(.failure(RMClientError.statusCodeIsNot200(response.statusCode)))
				return
			}

			guard let data = data else {
				completion(.failure(RMClientError.noData))
				return
			}

			do {
				let decoder = JSONDecoder()
				let object = try decoder.decode(T.self, from: data)
				completion(.success(object))
			}

			catch {
				let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
				let error = RMClientError.failedToDecode(message)
				completion(.failure(error))
			}
		}.resume()
	}

	private func dataTask<T: Decodable>(type: RMClientType, completion: @escaping (Result<T, Error>) -> Void) {
		let result = type.request
		switch result {
		case .success(let request):
			dataTask(with: request, completion: completion)
		case .failure(let error):
			completion(.failure(error))
		}
	}

	private func dataTask<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
		let request = URLRequest(url: url)
		dataTask(with: request, completion: completion)
	}

	public func getCharacters(completion: @escaping (Result<RMCharacterInfoModel, Error>) -> Void) {
		dataTask(type: .character, completion: completion)
	}

	public func getCharacters(page: String, completion: @escaping (Result<RMCharacterInfoModel, Error>) -> Void) {
		guard let url = URL(string: page) else { return }
		dataTask(with: url, completion: completion)
	}


}

