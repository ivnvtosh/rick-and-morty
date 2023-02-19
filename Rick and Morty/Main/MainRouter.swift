//
//  MainRouter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 13.11.2022
//

protocol MainRouterProtocol {
	func show(character: RMCharacterModel)
}

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController?

	func show(character: RMCharacterModel) {
		let characterViewController = CharacterModuleBuilder.build(with: character)
		characterViewController.modalPresentationStyle = .fullScreen
//		characterViewController.modalPresentationStyle = .custom
		characterViewController.transitioningDelegate = viewController
		viewController?.present(characterViewController, animated: true)
	}
}

