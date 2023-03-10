//
//  MainRouter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainRouter {
    
    weak var viewController: UIViewController?
	
	init(view: UIViewController) {
		
		self.viewController = view
	}
}

extension MainRouter: MainRouterProtocol {

    func show(_ character: CharacterEntity) {
        
        let characterViewController = CharacterModuleBuilder.build(with: character)

        characterViewController.modalPresentationStyle = .fullScreen

        viewController?.present(characterViewController, animated: true)
    }
    
	func show(_ error: Error, and loadCharaters: @escaping () -> ()) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Try again",
                                        style: .default,
                                        handler: { _ in
			loadCharaters()
        })
        
        alertController.addAction(alertAction)
        
        Task {
            
            await viewController?.present(alertController, animated: true)
        }
    }
    
    func show(_ error: Error) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: { _ in
            
            alertController.dismiss(animated: true)
        })
        
        alertController.addAction(alertAction)
        
        Task {
            
            await viewController?.present(alertController, animated: true)
        }
    }
}
