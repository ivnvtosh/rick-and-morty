//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainInteractor {
    
    weak var presenter: MainPresenterOutput?
    
    // FIXME: rename
    let rmClient = RickAndMortyService()
    var rmInfo: RMInfoModel?
    
    let imageService = ImageService()
}

extension MainInteractor: MainInteractorInput {

    func loadCharacter() async throws -> [CharacterEntity] {
        
        // FIXME: разбить на 2 метода
        if let nextPage = rmInfo?.next {
            
            let сharacters = try await rmClient.getCharacters(from: nextPage)
            
            rmInfo = сharacters.info
            
            return сharacters.results as! [CharacterEntity]
        }
        
        else {
            
            let сharacters = try await rmClient.getCharacters()
            
            rmInfo = сharacters.info
            
            return сharacters.results as! [CharacterEntity]
        }
    }
    
    func loadImage(with url: String) async throws -> UIImage {
        
        return try await imageService.load(with: url)
    }
}

extension MainInteractor: MainInteractorOutput {
    
}
