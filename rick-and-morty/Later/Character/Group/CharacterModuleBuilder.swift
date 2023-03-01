//
//  CharacterModuleBuilder.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 15.02.2023
//

import UIKit

class CharacterModuleBuilder {
	static func build(with character: RMCharacterModel) -> CharacterViewController {
		let interactor = CharacterInteractor()
		let router = CharacterRouter()
		let presenter = CharacterPresenter(interactor: interactor, router: router)
		let viewController = CharacterViewController()

		viewController.presenter = presenter
		presenter.view = viewController
		interactor.presenter = presenter
		router.viewController = viewController

		viewController.show(character: character)

		return viewController
	}
}

