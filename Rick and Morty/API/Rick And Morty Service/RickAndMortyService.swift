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
    
    // FIXME: rename
    /// Метод, который по запросу загружает JSON и проверят ответ
    /// - Parameters:
    ///     - with request URLRequest: Запрос.
    /// - Returns: Последовательность битов - JSON.
    private func session(with request: URLRequest) async throws -> Data {
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            
            throw RickAndMortyError.failedToConvertResponse
        }
        
        // FIXME: Обрабатыват ошибку 404?
        if response.statusCode != 200 {
            
            throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
        }
        
        return data
    }
    
    /// Универсальный метод, который расшифровывает данные в модель.
    /// - Parameters:
    ///     - T Decodable: Модель, которая будет получна из JSON.
    ///     - from data Data: Последовательность битов - JSON.
    /// - Returns: Результирующая модель.
    private func decode<T: Decodable>(from data: Data) throws -> T {
                
        do {
            
            return try JSONDecoder().decode(T.self, from: data)
        }
        
        catch {
            
            let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
            
            throw RickAndMortyError.failedToDecode(message)
        }
    }
    
    // FIXME: rename
    /// Универсальный метод, который по запросу загружает JSON и декодирует его в модель.
    /// - Parameters:
    ///     - T Decodable: Модель, которая будет получна из JSON
    ///     - with request URLRequest: Сформированный запрос.
    /// - Returns: Результирующая модель.
    private func dataTask<T: Decodable>(with request: URLRequest) async throws -> T {
        
        let data = try await session(with: request)
        
        return try decode(from: data)
    }
    
    /// Универсальный метод, который формирует запроc по готовой ссылке и затем выполяняет его.
    /// - Parameters:
    ///     - with url URL: Ссылка для загрузки.
    /// - Returns: Возвращает модель.
    private func dataTask<T: Decodable>(with url: URL) async throws -> T {
        
        // FIXME: Дублируется
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 10)
        
        return try await dataTask(with: request)
    }
}

extension RickAndMortyService: RickAndMortyProtocol {
	
	// MARK: - Characters
	
	/// Метод, который выполняет сетевой запрос, для получения актуальной ифнормации по персонажам.
	/// - Returns: Возвращает модель, которая содержит массив первых 10 персонажей и курсор.
	public func getCharacters() async throws -> CharacterInfoModel {
		
		let request = try URLRequestBuilder(base: "https://rickandmortyapi.com", path: "/api/character")
            .set(method: .get)
            .build()
		
		return try await dataTask(with: request)
	}
	
	/// Метод выполняет сетевой запрос, для получения актуальной ифнормации по персонажам.
	/// - Parameters:
	///     - from page String: ссылка на страницу, с которой будут получены данные.
	/// - Returns: Возвращает модель, которая содержит массив 10 персонажей и курсор, по текущей страницы.
	public func getCharacters(from page: String) async throws -> CharacterInfoModel {
		
        // FIXME: Тоже использовать builder?
		guard let url = URL(string: page) else {
			
			throw RickAndMortyError.invalidURL
		}
		
		return try await dataTask(with: url)
	}
}
