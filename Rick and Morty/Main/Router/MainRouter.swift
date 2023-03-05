//
//  MainRouter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainRouter {
    
    weak var viewController: UIViewController?

    // FIXME: Убрать
	let transitioningDelegate = TransitioningDelegate()
	
	init(view: UIViewController) {
		
		self.viewController = view
	}
}

extension MainRouter: MainRouterProtocol {

    func showCharacter(_ character: CharacterEntity, originFrame: CGRect) {
        
//        let characterViewController = CharacterModuleBuilder.build(with: character)
//
//        transitioningDelegate.presentationAnimation = CharacterAnimator(originFrame: originFrame, isPresented: true)
//        transitioningDelegate.dismissalAnimation = CharacterAnimator(originFrame: originFrame, isPresented: false)
//        characterViewController.transitioningDelegate = transitioningDelegate
//        characterViewController.modalPresentationStyle = .fullScreen
//
//        viewController?.present(characterViewController, animated: true)
    }
}
