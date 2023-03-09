//
//  ImageService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

/// Сервис выполянет сетевой запрос для загрузки и кэширования изображения.
/// В случае если изображение уже присутсвует в кэше, то загрузка выпоняться не будет.
class ImageService {

    /// Метод загружает и кэширует изображение.
    /// - Parameters:
    ///     - with imageURL String: Cсылка на изображение.
    /// - Returns: Возвращает изображение UIImage.
    func load(with url: String) async throws -> UIImage {
        
        guard let url = URL(string: url) else {
            
            throw ImageError.invalidURL
        }
        
		let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
		
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            
            throw RickAndMortyError.failedToConvertResponse
        }
        
        if response.statusCode != 200 {
            
            throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
        }
        
        guard let image = UIImage(data: data) else {
            
            throw ImageError.notInitializeImageFromData
        }
        
        return image
    }
}
