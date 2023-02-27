//
//  CharacterAnimator.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 25.02.2023.
//

import UIKit

class CharacterAnimator: NSObject, TransitionAnimation {
	var interactionController: UIViewControllerInteractiveTransitioning?
	
	let duration: TimeInterval = 0.3
	var originFrame: CGRect = .zero
	let isPresented: Bool
	
	init(originFrame: CGRect, isPresented: Bool) {
		self.originFrame = originFrame
		self.isPresented = isPresented
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let toView = transitionContext.view(forKey: .to)!
		let fromView = isPresented ? toView : transitionContext.view(forKey: .from)!
		
		let containerView = transitionContext.containerView
		
		containerView.addSubview(toView)
		//		containerView.addSubview(fromView)
		containerView.bringSubviewToFront(fromView)
		
		let initialFrame = isPresented ? originFrame : fromView.frame
		let finalFrame = isPresented ? fromView.frame : originFrame
		let xScaleFactor = isPresented ?
		initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
		let yScaleFactor = isPresented ?
		initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
		
		let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
		
		if isPresented {
			fromView.transform = scaleTransform
			fromView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
			fromView.clipsToBounds = true
		}
		
		fromView.layer.cornerRadius = isPresented ? 20.0 : 0.0
		fromView.layer.masksToBounds = true
		
		UIView.animate(
			withDuration: duration,
			animations: { [self] in				
				fromView.transform = isPresented ? .identity : scaleTransform
				fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
				fromView.layer.cornerRadius = !isPresented ? 20.0 : 0.0
			},
			completion: { _ in
				transitionContext.completeTransition(true)
			}
		)
		
		
	}
}

