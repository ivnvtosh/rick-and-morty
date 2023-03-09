//
//  MainModuleBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainModuleBuilder {
    
    private let imageService: ImageServiceProtocol
    private let rickAndMortyService: RickAndMortyServiceProtocol
    
    init(imageService: ImageServiceProtocol,
         rickAndMortyService: RickAndMortyServiceProtocol) {
        
        self.imageService = imageService
        self.rickAndMortyService = rickAndMortyService
    }
}

extension MainModuleBuilder: MainModuleBuilderProtocol {
	
	func build() -> MainViewController {
		
		let viewController = MainViewController()
        let interactor = MainInteractor(imageService: imageService, rickAndMortyService: rickAndMortyService)
		let router = MainRouter(view: viewController)
		let presenter = MainPresenter(view: viewController,
									  interactor: interactor,
									  router: router)
		
		viewController.presenter = presenter
		interactor.presenter = presenter
		
		return viewController
	}
}
