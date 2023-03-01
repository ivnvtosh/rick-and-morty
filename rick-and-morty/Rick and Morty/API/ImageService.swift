//
//  ImageService.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

// FIXME: файл?
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

// презентер принимает решение надо ли загружать или подтянуть из кэша?
// Если ImageCashe в файл, то в какую папку?

// функциональности в 2 функции! // Почитал книжку и да, так необходимо сделать!!!

// FIXME: Запрещено создавать объекты с использованием паттерна singleton
// Что это значит?


/// Сервис выполянет сетевой запрос для загрузки и кэширования изображения.
/// В случае если изображение уже присутсвует в кэше, то загрузка выпоняться не будет.
class ImageService {
    

    // Нужно описывать свойства?
    private static let imageCache = NSCache<NSString, UIImage>()
    
    /// Метод загружает и кэширует изображение.
    /// - Parameters:
    ///     - with imageURL String: Cсылка на изображение.
    /// - Returns: Возвращает изображение UIImage.
    func load(with imageURL: String) async throws -> UIImage {
        
        guard let url = URL(string: imageURL) else { // FIXME: rename imageURL
            
            throw ImageError.invalidURL
        }

        if let cachedImage = ImageService.imageCache.object(forKey: imageURL as NSString) {
            
            return cachedImage
        }
        
        do { // FIXME: первое ключевое слово это "do"
            // FIXME: response
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

