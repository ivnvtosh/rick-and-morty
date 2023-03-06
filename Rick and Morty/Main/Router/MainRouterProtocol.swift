//
//  MainRouterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol MainRouterProtocol {
    
    func showCharacter(_ character: CharacterEntity, originFrame: CGRect)
}

// FIXME: Я часто наблюдаю, что класс роутер используют как builder
