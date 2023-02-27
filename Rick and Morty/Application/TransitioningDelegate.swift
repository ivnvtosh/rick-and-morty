//
//  CharacterAnimation.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 25.02.2023.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
	var presentationAnimation: TransitionAnimation?
	var dismissalAnimation: TransitionAnimation?

	func animationController(forPresented presented: UIViewController,
							 presenting: UIViewController,
							 source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		presentationAnimation
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		dismissalAnimation
	}

	func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning)
		-> UIViewControllerInteractiveTransitioning? {
		presentationAnimation?.interactionController
	}

	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
		-> UIViewControllerInteractiveTransitioning? {
		dismissalAnimation?.interactionController
	}
}

