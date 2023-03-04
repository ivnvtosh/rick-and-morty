//
//  MainPresenterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainPresenterInput: AnyObject {
    
    func viewDidLoad()
    
    func imageDidLoad(with url: String, completion: @escaping ((UIImage) async -> Void))
        
    func didSelectItemAt(character: CharacterEntity, originFrame: CGRect)
}

protocol MainPresenterOutput: AnyObject {

}
