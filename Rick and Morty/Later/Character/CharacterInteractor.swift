//
//  CharacterInteractor.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 15.02.2023
//

protocol CharacterInteractorProtocol: AnyObject {
	
}

class CharacterInteractor: CharacterInteractorProtocol {
    weak var presenter: CharacterPresenterProtocol?

	
}

