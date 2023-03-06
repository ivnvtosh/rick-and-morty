//
//  CharacterEntity.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 04.03.2023.
//

// FIXME: Стоит ли модель делать полную?
struct CharacterEntity {
    
    let id: Int
    
    let name: String
    
    let status: RMCharacterStatusModel
    
    let species: String
    
    let type: String
    
    let gender: RMCharacterGenderModel
    
	// FIXME: Сам хз что это, то есть буквально название ничего не говорит
    let origin: RMCharacterOriginModel
    
    let location: RMCharacterLocationModel
    
	// FIXME: переименовать на imageURL?
    let image: String
    
	// FIXME: Или перемеиновать?
	/// Соддержит ссылки на эпизоды, в которых встречался персонаж
    let episode: [String]
    
    let url: String
    
    let created: String

	// FIXME: бан
	init(model: RMCharacterModel) throws {
		
		guard let id = model.id,
			  let name = model.name,
			  let status = model.status,
			  let species = model.species,
			  let type = model.type,
			  let gender = model.gender,
			  let origin = model.origin,
			  let location = model.location,
			  let image = model.image,
			  let episode = model.episode,
			  let url = model.url,
			  let created = model.created else {
			
            // FIXME: бан
			throw MainInteractorError.failedToConvertEntity
		}
		
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
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
