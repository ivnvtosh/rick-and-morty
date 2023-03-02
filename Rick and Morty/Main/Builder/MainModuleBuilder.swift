//
//  MainModuleBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

// FIXME: Использовать паттерн - Builder? думаю, нет // То что у меня это не Builder
// FIXME: Переименовать на Assembly?
class MainModuleBuilder {
    
    // FIXME: Переименовать?
    static func build() -> MainViewController {
        
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
