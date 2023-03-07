//
//  MainRouter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainRouter {
    
    weak var viewController: UIViewController?

    // FIXME: Убрать
	let transitioningDelegate = TransitioningDelegate()
	
	init(view: UIViewController) {
		
		self.viewController = view
	}
}

extension MainRouter: MainRouterProtocol {

    func show(_ character: CharacterEntity, originFrame: CGRect) {
        
        let characterViewController = CharacterModuleBuilder.build(with: character)

        transitioningDelegate.presentationAnimation = CharacterAnimator(originFrame: originFrame, isPresented: true)
        transitioningDelegate.dismissalAnimation = CharacterAnimator(originFrame: originFrame, isPresented: false)
        characterViewController.transitioningDelegate = transitioningDelegate
        characterViewController.modalPresentationStyle = .fullScreen

        viewController?.present(characterViewController, animated: true)
    }
    
    // FIXME: handler
    func show(_ error: Error) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
//        let alertAction = UIAlertAction(title: "Try again",
//                                        style: .default,
//                                        handler: { [weak viewController]  _ in
//            viewController?.presenter?.viewDidLoad()
//        })
//        
//        alertController.addAction(alertAction)
        
        Task {
            
            await viewController?.present(alertController, animated: true)
        }
    }
}
