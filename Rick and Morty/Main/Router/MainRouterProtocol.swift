//
//  MainRouterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol MainRouterProtocol {
    
    // FIXME: rename present(character:) or rename presentCharacter(_:)?
    func show(character: RMCharacterModel, originFrame: CGRect)
}
