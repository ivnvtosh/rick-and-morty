//
//  ImageService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

/// Это сервис для загрузки и кэширования изображения
class ImageService {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    /// Метод, который загружает и кэширует изображение по ссылке
    /// - Parameters:
    ///     - with imageURL String: ссылка на изображение
    ///     - completion @escaping ((Result<UIImage, Error>) -> Void): замыкание, которое примит ответ - result
    ///         - Result<UIImage, Error> - в случае успеха - изображение, в случае неудачи - ошибка
    func load(with imageURL: String) async throws -> UIImage {
        
        let url = URL(string: imageURL)!

//        guard let url = URL(string: imageURL) else { // FIXME: guard let URL = URL?
//            return
//        }
        
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

