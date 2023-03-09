//
//  MainInteractorProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainInteractorInput: AnyObject {
    
    var characterEntity: [CharacterEntity]? { get }
    
    func loadCharacter() async throws -> [CharacterEntity]
    func loadNextCharacters() async throws -> [CharacterEntity]
    
    func loadImage(with url: String) async throws -> UIImage
}

protocol MainInteractorOutput: AnyObject { }
