//
//  StartModuleBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 08.02.2023
//

import UIKit

class StartModuleBuilder {
	static func build() -> StartViewController {
		let interactor = StartInteractor()
		let router = StartRouter()
		let presenter = StartPresenter(interactor: interactor, router: router)
		let viewController = StartViewController()

		viewController.presenter = presenter
		presenter.view = viewController
		interactor.presenter = presenter
		router.viewController = viewController

		return viewController
	}
}

