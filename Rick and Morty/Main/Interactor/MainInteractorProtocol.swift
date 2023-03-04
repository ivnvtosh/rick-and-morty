//
//  MainInteractorProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

// FIXME: Организация проекта - Как сортировать файлы?
// FIXME: Какая примерная длина строки?
// FIXME: Assets - норм?
// FIXME: Я часто видел, что некоторые файлы называют: view+extension. Когда стоит что-то инкапсулировать во view?

protocol MainInteractorInput: AnyObject {
    
    func loadCharacter() async throws -> [CharacterEntity]
    
    func loadImage(with url: String) async throws -> UIImage
}

// FIXME: Когда используется?
protocol MainInteractorOutput: AnyObject {
    
}
