//
//  MainModuleBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainModuleBuilder {

}

extension MainModuleBuilder: MainModuleBuilderProtocol {
	
	func build() -> MainViewController {
		
		let viewController = MainViewController()
		let interactor = MainInteractor()
		let router = MainRouter(view: viewController)
		let presenter = MainPresenter(view: viewController,
									  interactor: interactor,
									  router: router)
		
		viewController.presenter = presenter
		interactor.presenter = presenter
		
		return viewController
	}
}
