//
//  MainRouter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController?

	let transitioningDelegate = TransitioningDelegate()


	func show(character: RMCharacterModel, originFrame: CGRect) {
        
		let characterViewController = CharacterModuleBuilder.build(with: character)
        
		transitioningDelegate.presentationAnimation = CharacterAnimator(originFrame: originFrame, isPresented: true)
		transitioningDelegate.dismissalAnimation = CharacterAnimator(originFrame: originFrame, isPresented: false)
		characterViewController.transitioningDelegate = transitioningDelegate
        characterViewController.modalPresentationStyle = .fullScreen
//        characterViewController.modalPresentationStyle = .custom
        
		viewController?.present(characterViewController, animated: true)
	}
}

