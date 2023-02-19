//
//  CharacterAnimator.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 17.02.2023.
//

import UIKit

class MainAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
	let duration = 0.3
	
	var isPresented = true
	var originFrame = CGRect.zero
	var dismissCompletion: (() -> Void)?
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		if !self.isPresented {
			self.dismissCompletion?()
		}
		
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
			animations: {
				fromView.transform = self.isPresented ? .identity : scaleTransform
				fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
				fromView.layer.cornerRadius = !self.isPresented ? 20.0 : 0.0
			},
			completion: { _ in
				transitionContext.completeTransition(true)
			})
	}
}
