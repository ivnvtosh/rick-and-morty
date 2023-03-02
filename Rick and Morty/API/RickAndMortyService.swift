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
        
        if response.statusCode != 200 {
            
            throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
        }
        
        do {
            
            // FIXME: Нужно ли вынести объект декодера в член класса?
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            
            return object
        }
        
        catch {
            
            let message = String(data: data, encoding: .utf8) ?? "Unknown encoding"
            
            throw RickAndMortyError.failedToDecode(message)
        }
    }
    
    /// Универсальный метод, который формирует один из трех возможных вариантов запрос и затем выполяняет его.
    /// - Parameters:
    ///     - type RickAndMortyTypeWithRequest: enum, который составляет
    ///       один из трех возможных вариантов запроса: character, location, episode.
    /// - Returns: Возвращает одну из моделей: RMCharacterInfoModel, RMLocationInfoModel, RMEpisodeInfoModel.
    private func dataTask<T: Decodable>(type: RickAndMortyTypeWithRequest) async throws -> T {
        
        let request = try type.getRequest()
        
        return try await dataTask(with: request)
    }
    
    /// Универсальный метод, который формирует запроc по готовой ссылке и затем выполяняет его.
    /// - Parameters:
    ///     - with url URL: Ссылка для загрузки.
    /// - Returns: Возвращает модель.
    private func dataTask<T: Decodable>(with url: URL) async throws -> T {
        
        let request = URLRequest(url: url)
        
        return try await dataTask(with: request)
    }
    
    // MARK: - Characters
    
    /// Метод, который выполняет сетевой запрос, для получения актуальной ифнормации по персонажам.
    /// - Returns: Возвращает модель, которая содержит массив первых 10 персонажей и курсор.
    public func getCharacters() async throws -> RMCharacterInfoModel {
        
        try await dataTask(type: .character)
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
