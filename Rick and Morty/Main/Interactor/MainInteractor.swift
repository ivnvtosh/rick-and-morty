//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainInteractor {
    
    weak var presenter: MainPresenter?
    
    private let imageService: ImageService
	private let rickAndMortyService: RickAndMortyProtocol
    
    var infoEntity: InfoEntity?
    var characterEntity: [CharacterEntity]?
	
	init() {
		
		self.rickAndMortyService = RickAndMortyService()
		self.imageService = ImageService()
	}
}

extension MainInteractor: MainInteractorInput {
	
    func loadCharacterNext() async throws -> [CharacterEntity] {
        
        guard let nextPage = infoEntity?.next else {
            
            throw RickAndMortyError.invalidURL
        }
        
        let сharactersWithInfo = try await rickAndMortyService.getCharacters(from: nextPage)
        
        infoEntity = InfoEntity(model: сharactersWithInfo.info)
        let characterModels = сharactersWithInfo.results
        
        let characterEntity = characterModels.map { CharacterEntity(model: $0) }
        
        self.characterEntity = characterEntity
        
        return characterEntity
    }
    
    func loadCharacter() async throws -> [CharacterEntity] {
        
        let сharactersWithInfo = try await rickAndMortyService.getCharacters()
        
        infoEntity = InfoEntity(model: сharactersWithInfo.info)
        let characterModels = сharactersWithInfo.results
        
        let characterEntity = characterModels.map { CharacterEntity(model: $0) }
        
        self.characterEntity = characterEntity
        
        return characterEntity
    }
    
    func loadImage(with url: String) async throws -> UIImage {
        
        try await imageService.load(with: url)
    }
}

extension MainInteractor: MainInteractorOutput { }
