//
//  RickAndMortyService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022.
//

import UIKit

/// Сервис для получения актуальной информации по
/// персонажам, локациям и эпизодам по мультсериалу "Рик и Морти".
class RickAndMortyService {
    
    /// Универсальный метод, который по запросу загружает JSON и декодирует его в модель.
    /// - Parameters:
    ///     - T Decodable: Модель, которая будет получна из JSON
    ///     - with request URLRequest: Сформированный запрос.
    /// - Returns: Результирующая модель.
    private func dataTask<T: Decodable>(with request: URLRequest) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            
            throw RickAndMortyError.failedToConvertResponse
        }
        
		// FIXME: ошибка 404
        if response.statusCode != 200 {
            
            throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
        }
		
        do {
            
            // FIXME: Нужно ли вынести декодер в член класса?
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            
            return object
        }
        
        catch {
            
            let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
            
            throw RickAndMortyError.failedToDecode(message)
        }
    }
        
    /// Универсальный метод, который формирует запроc по готовой ссылке и затем выполяняет его.
    /// - Parameters:
    ///     - with url URL: Ссылка для загрузки.
    /// - Returns: Возвращает модель.
    private func dataTask<T: Decodable>(with url: URL) async throws -> T {
        
        let request = URLRequest(url: url)
        
        return try await dataTask(with: request)
    }
}

extension RickAndMortyService: RickAndMortyProtocol {
	
	// MARK: - Characters
	
	/// Метод, который выполняет сетевой запрос, для получения актуальной ифнормации по персонажам.
	/// - Returns: Возвращает модель, которая содержит массив первых 10 персонажей и курсор.
	public func getCharacters() async throws -> RMCharacterInfoModel {
		
		let request = try RequestCharactersBuilder.build()
		
		return try await dataTask(with: request)
	}
	
	/// Метод выполняет сетевой запрос, для получения актуальной ифнормации по персонажам.
	/// - Parameters:
	///     - from page String: ссылка на страницу, с которой будут получены данные.
	/// - Returns: Возвращает модель, которая содержит массив 10 персонажей и курсор, по текущей страницы.
	public func getCharacters(from page: String) async throws -> RMCharacterInfoModel {
		
		guard let url = URL(string: page) else {
			
			throw RickAndMortyError.invalidURL
		}
		
		return try await dataTask(with: url)
	}
}
