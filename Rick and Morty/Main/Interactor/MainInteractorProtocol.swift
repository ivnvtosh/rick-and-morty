//
//  MainInteractorProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainInteractorInput: AnyObject {
    
    func loadCharacter() async throws -> [CharacterEntity]
    func loadCharacterNext() async throws -> [CharacterEntity]
    
    func loadImage(with url: String) async throws -> UIImage
}

protocol MainInteractorOutput: AnyObject { }
