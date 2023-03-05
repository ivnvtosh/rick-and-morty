//
//  CharacterPresenter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 15.02.2023
//

protocol CharacterPresenterProtocol: AnyObject {
	
}

class CharacterPresenter {
    weak var view: CharacterViewProtocol?
    var router: CharacterRouterProtocol
    var interactor: CharacterInteractorProtocol

    init(interactor: CharacterInteractorProtocol, router: CharacterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CharacterPresenter: CharacterPresenterProtocol {
	
}

