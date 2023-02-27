//
//  MainViewProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func show(characters: [RMCharacterModel])
    func show(error: Error)
}
