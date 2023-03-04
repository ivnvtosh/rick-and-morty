//
//  MainViewProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
    func showCharacters(_ characters: [CharacterEntity]) async
    func showError(_ error: Error)
}
