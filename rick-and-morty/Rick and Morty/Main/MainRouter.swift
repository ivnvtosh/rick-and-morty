//
//  MainRouter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

protocol MainRouterProtocol {
	func show(character: RMCharacterModel, originFrame: CGRect)
}

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController?

	let transitioningDelegate = TransitioningDelegate()


	func show(character: RMCharacterModel, originFrame: CGRect) {
		let characterViewController = CharacterModuleBuilder.build(with: character)
		characterViewController.modalPresentationStyle = .fullScreen
//		characterViewController.modalPresentationStyle = .custom

		transitioningDelegate.presentationAnimation = CharacterAnimator(originFrame: originFrame, isPresented: true)
		transitioningDelegate.dismissalAnimation = CharacterAnimator(originFrame: originFrame, isPresented: false)
		characterViewController.transitioningDelegate = transitioningDelegate

		viewController?.present(characterViewController, animated: true)
	}
}

