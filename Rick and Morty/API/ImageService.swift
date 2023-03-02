//
//  ImageService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

// FIXME: Разбить на 2 класса ImageService и ImageCashe
/// Сервис выполянет сетевой запрос для загрузки и кэширования изображения.
/// В случае если изображение уже присутсвует в кэше, то загрузка выпоняться не будет.
class ImageService {
    
    // FIXME: Убрать статик
    private static let imageCache = NSCache<NSString, UIImage>()
    
    // FIXME: rename imageURL (если класс разбить на 2 класса, то эта пробелма пропадет)
    /// Метод загружает и кэширует изображение.
    /// - Parameters:
    ///     - with imageURL String: Cсылка на изображение.
    /// - Returns: Возвращает изображение UIImage.
    func load(with imageURL: String) async throws -> UIImage {
        
        guard let url = URL(string: imageURL) else {
            
            throw ImageError.invalidURL
        }
        
        // FIXME: Код не синхронизирован
        if let cachedImage = ImageService.imageCache.object(forKey: imageURL as NSString) {
            
            return cachedImage
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                
                throw RickAndMortyError.failedToConvertResponse
            }
            
            if response.statusCode != 200 {
                
                throw RickAndMortyError.statusCodeIsNot200(response.statusCode)
            }
            
            guard let image = UIImage(data: data) else {
                
                throw ImageError.notInitializeImageFromData
            }
            
            // FIXME: Код не синхронизирован
            ImageService.imageCache.setObject(image, forKey: imageURL as NSString)
            
            return image
        }
        
        catch {
            
            throw error
        }
    }
}
