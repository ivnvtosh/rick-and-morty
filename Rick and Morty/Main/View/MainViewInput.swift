//
//  MainViewProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainViewInput: AnyObject {
    
    func show(_ characters: [CharacterEntity]) async
}

protocol MainViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func didDisplayCell(with url: String, completion: @escaping ((UIImage) async -> Void))
        
    func didSelectItemAt(character: CharacterEntity, originFrame: CGRect)
    
    func willDisplayCell()
}
