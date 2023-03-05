//
//  StartRouter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 08.02.2023
//

protocol StartRouterProtocol {
	func OpenMainScrean()
}

class StartRouter: StartRouterProtocol {
    weak var viewController: StartViewController?

	func OpenMainScrean() {
//		let mainViewController = MainModuleBuilder.build()
//		mainViewController.modalPresentationStyle = .fullScreen
//		viewController?.present(mainViewController, animated: true)
	}
}

