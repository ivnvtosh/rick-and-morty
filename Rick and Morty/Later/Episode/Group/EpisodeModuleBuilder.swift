//
//  EpisodeModuleBuilder.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

import UIKit

class EpisodeModuleBuilder {
	static func build() -> EpisodeViewController {
		let interactor = EpisodeInteractor()
		let router = EpisodeRouter()
		let presenter = EpisodePresenter(interactor: interactor, router: router)
		let viewController = EpisodeViewController()

		viewController.presenter = presenter
		presenter.view = viewController
		interactor.presenter = presenter
		router.viewController = viewController

		return viewController
	}
}

