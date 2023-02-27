//
//  LocationModuleBuilder.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

import UIKit

class LocationModuleBuilder {
	static func build() -> LocationViewController {
		let interactor = LocationInteractor()
		let router = LocationRouter()
		let presenter = LocationPresenter(interactor: interactor, router: router)
		let viewController = LocationViewController()

		viewController.presenter = presenter
		presenter.view = viewController
		interactor.presenter = presenter
		router.viewController = viewController

		return viewController
	}
}

