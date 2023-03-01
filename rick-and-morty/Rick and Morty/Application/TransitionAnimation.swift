//
//  TransitionAnimation.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 25.02.2023.
//

import UIKit

protocol TransitionAnimation: UIViewControllerAnimatedTransitioning {
    
	var interactionController: UIViewControllerInteractiveTransitioning? { get }
}

