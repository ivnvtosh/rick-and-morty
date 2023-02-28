//
//  ImageService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

/// A type representing an error value that can be thrown.
enum ImageError: Error {
    case invalidURL
}

// FIXME: Каждая сущность должна иметь одну причину для изменений, где сущность это протокол, класс, метод, переменная и т.д.
// По идее проверка, на то что изображение загружено или нет, должна происходит в презентаре,
// но тут появляется проблемв с дублированием кода, или это нормальная практика?
// Хотя нет, интерактор должен ответить на вопрос:
// Необходимо загрузить из интернета или с устройства?
// Но как назвать этот объект? ImageCashe?


/// Сервис выполянет сетевой запрос для загрузки изображения, а также кэширует его.
class ImageService {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    /// Метод загружает и кэширует изображение.
    /// - Parameters:
    ///     - with imageURL String: Cсылка на изображение.
    /// - Returns: Возвращает изображение UIImage.
    func load(with imageURL: String) async throws -> UIImage {
        
        guard let url = URL(string: imageURL) else {
            
            throw ImageError.invalidURL
        }

        if let cachedImage = ImageService.imageCache.object(forKey: imageURL as NSString) {
            
            return cachedImage
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)!
            ImageService.imageCache.setObject(image, forKey: imageURL as NSString)
            
            return image
        }
        catch {
            
            throw error
        }
    }
}

