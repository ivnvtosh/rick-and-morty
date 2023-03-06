//
//  CharacterViewProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol CharacterViewProtocol: AnyObject {
    func show(character: CharacterEntity)
    func show(image: UIImage)
}

