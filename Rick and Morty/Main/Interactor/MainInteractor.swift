//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainInteractor {
    
    weak var presenter: MainPresenter?
    
    private let imageService: ImageServiceProtocol
	private let rickAndMortyService: RickAndMortyServiceProtocol
    
    var infoEntity: InfoEntity?
    var characterEntity: [CharacterEntity]?
	
	init(imageService: ImageServiceProtocol,
         rickAndMortyService: RickAndMortyServiceProtocol) {
        
        self.imageService = imageService
        self.rickAndMortyService = rickAndMortyService
	}
}

extension MainInteractor: MainInteractorInput {
	
    func loadCharacter() async throws -> [CharacterEntity] {
        
        let сharactersWithInfo = try await rickAndMortyService.getCharacters()
        
        infoEntity = InfoEntity(model: сharactersWithInfo.info)
        
        let characterEntity = сharactersWithInfo.results.map { CharacterEntity(model: $0) }
        self.characterEntity = characterEntity
        
        return characterEntity
    }
    
    func loadNextCharacters() async throws -> [CharacterEntity] {
        
        guard let nextPage = infoEntity?.next else {
            
            throw RickAndMortyError.invalidURL
        }
        
        let сharactersWithInfo = try await rickAndMortyService.getCharacters(from: nextPage)
        
        infoEntity = InfoEntity(model: сharactersWithInfo.info)
        
        let characterEntity = сharactersWithInfo.results.map { CharacterEntity(model: $0) }
        self.characterEntity?.append(contentsOf: characterEntity)
        
        return characterEntity
    }
    
    func loadImage(with url: String) async throws -> UIImage {
        
        try await imageService.load(with: url)
    }
}

extension MainInteractor: MainInteractorOutput { }
