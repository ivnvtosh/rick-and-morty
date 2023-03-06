//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainInteractor {
    
    weak var presenter: MainPresenterOutput?
    
    // FIXME: rename and add protocol
	let rickAndMortyService: RickAndMortyProtocol
    var rickAndMortyInfo: RMInfoModel?
    
	let imageService: ImageService
	
	init() {
		
		self.rickAndMortyService = RickAndMortyService()
		self.imageService = ImageService()
	}
}

extension MainInteractor: MainInteractorInput {
	
    func loadCharacter() async throws -> [CharacterEntity] {
        
		let сharactersWithInfo: RMCharacterInfoModel?
        
        if let nextPage = rickAndMortyInfo?.next {
            
			сharactersWithInfo = try await rickAndMortyService.getCharacters(from: nextPage)
        }
        
        else {
            
			сharactersWithInfo = try await rickAndMortyService.getCharacters()
        }
		
		guard let сharactersWithInfo,
			  let info = сharactersWithInfo.info,
			  let characterModels = сharactersWithInfo.results else {
			
			throw MainInteractorError.noData
		}
		
		rickAndMortyInfo = info
		
		// FIXME: бан
		let characters = try characterModels.map { try CharacterEntity(model: $0) }
		
		return characters
    }
    
    func loadImage(with url: String) async throws -> UIImage {
        
        return try await imageService.load(with: url)
    }
}

extension MainInteractor: MainInteractorOutput {
    
}
