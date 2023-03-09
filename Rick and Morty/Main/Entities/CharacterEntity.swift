//
//  CharacterEntity.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 04.03.2023.
//

import UIKit

struct CharacterEntity {
    
    let id: Int
    
    let name: String
    
    let status: CharacterStatus
    
    let species: String
    
    let type: String
    
    let gender: CharacterGender
    
	// FIXME: Сам хз что это, то есть буквально название ничего не говорит
    let origin: CharacterOriginModel
    
    let location: CharacterLocationModel
    
	// FIXME: переименовать на imageURL?
    let image: String
    
    var uiimage: UIImage?
    
	// FIXME: Или перемеиновать?
	/// Соддержит ссылки на эпизоды, в которых встречался персонаж
    let episode: [String]
    
    let url: String
    
    let created: String

	init(model: CharacterModel) {
		
        id = model.id
        name = model.name
        status = CharacterStatus(rawValue: model.status) ?? .none
        species = model.species
        type = model.type
        gender = CharacterGender(rawValue: model.gender) ?? .none
        origin = model.origin
        location = model.location
        image = model.image
        episode = model.episode
        url = model.url
        created = model.created
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
