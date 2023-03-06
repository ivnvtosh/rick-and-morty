//
//  RickAndMortyService.swift
//  Rick and Morty Tests
//
//  Created by Anton Ivanov on 06.03.2023.
//

import XCTest
@testable import Rick_and_Morty

final class RickAndMortyServiceTests: XCTestCase {

    // FIXME: sud?
    var rickAndMortyService: RickAndMortyProtocol!
    
    
    // FIXME: setUp?
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        rickAndMortyService = RickAndMortyService()
    }

    override func tearDownWithError() throws {
        
        rickAndMortyService = nil
        
        try super.tearDownWithError()
    }

    actor CharacterModelsActor {
        
        var characterModels: RMCharacterInfoModel?
        
        func setCharacterModels(new: RMCharacterInfoModel) {
            
            characterModels = new
        }
    }
    
    func testGetCharacter() throws {
        
        // GIVEN
        
        let didReceiveResponse = XCTestExpectation(description: #function)
        
        let characterModelsActor = CharacterModelsActor()
        
        // WHEN
        
        Task {
            
            let characterModels = try await rickAndMortyService.getCharacters()
            
            await characterModelsActor.setCharacterModels(new: characterModels)
            
            didReceiveResponse.fulfill()
        }
        
        wait(for: [didReceiveResponse], timeout: 10)
        
        // THEN
        
        Task {
            
            let characterModels = await characterModelsActor.characterModels
            
            XCTAssertNotNil(characterModels?.info)
            XCTAssertNotNil(characterModels?.results)
        }
    }
    
    func testGetCharactersMeasure() throws {
        
        measure {
            
            Task {
                
                let _ = try await rickAndMortyService.getCharacters()
            }
        }
    }
}
