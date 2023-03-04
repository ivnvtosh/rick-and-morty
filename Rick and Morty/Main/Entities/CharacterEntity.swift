//
//  CharacterEntity.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 04.03.2023.
//

struct CharacterEntity {
    
    let id: Int
    
    let name: String
    
    let status: RMCharacterStatusModel
    
    let species: String
    
    let type: String
    
    let gender: RMCharacterGenderModel
    
    let origin: RMCharacterOriginModel
    
    let location: RMCharacterLocationModel
    
    let image: String
    
    let episode: [String]
    
    let url: String
    
    let created: String
    
    
    init(model: RMCharacterModel) {
        
        self.id = model.id!
        self.name = model.name!
        self.status = model.status!
        self.species = model.species!
        self.type = model.type!
        self.gender = model.gender!
        self.origin = model.origin!
        self.location = model.location!
        self.image = model.image!
        self.episode = model.episode!
        self.url = model.url!
        self.created = model.created!
    }
    
    func getStatusPathForImage() -> String {
        
        switch status {
            
        case .alive:
            return "RMColorGreen"
            
        case .dead:
            return "RMColorRed"
            
        case .unknown:
            return "RMColorGray"
            
        case .none:
            return "RMColorGray"
        }
    }
}
