//
//  CharacterInteractorProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol CharacterInteractorProtocol: AnyObject {
    func loadImage(with url: String) async
}

