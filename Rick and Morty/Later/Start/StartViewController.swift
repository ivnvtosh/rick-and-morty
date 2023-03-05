//
//  StartViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 08.02.2023
//

import UIKit

protocol StartViewProtocol: AnyObject {
	
}

class StartViewController: UIViewController {
    var presenter: StartPresenterProtocol?

	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.alpha = 0.5
		imageView.contentMode = .scaleAspectFill
		let image = UIImage(named: "RMImage")
		imageView.image = image
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
		return imageView
	}()
	
	lazy var label: UILabel = {
		let label = UILabel()
		label.text = "The Rick and Morty API"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 32)
		label.textColor = .white
//		label.backgroundColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		return label
	}()
	
	lazy var backView1: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(view)
		return view
	}()
	
	lazy var blurView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		backView.addSubview(blurEffectView)
		return blurEffectView
	}()
	
	lazy var blurView1: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.layer.cornerRadius = 8
		blurEffectView.clipsToBounds = true
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		backView1.addSubview(blurEffectView)
		return blurEffectView
	}()
	
	lazy var descriptionLabel: UIView = {
		let label = UILabel()
		label.text = "This app shows all the characters of the series Rick and Morty"
		label.textAlignment = .center
		label.numberOfLines = 0
//		label.font = UIFont.boldSystemFont(ofSize: 32)
		label.textColor = .white
//		label.backgroundColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		backView1.addSubview(label)
		return label
	}()
	
	lazy var backView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(view)
		return view
	}()
	
	lazy var button: UIButton = {
		let button = UIButton(type: .system)
		button.configuration = .filled()
		button.setTitle("Okay", for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		backView.addSubview(button)
		return button
	}()
	
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .black
		let constraints = [
			
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			label.topAnchor.constraint(equalTo: view.topAnchor),
			label.heightAnchor.constraint(equalToConstant: 200),
			
			backView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			backView1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			backView1.heightAnchor.constraint(equalToConstant: 120),
			backView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			backView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			blurView1.leadingAnchor.constraint(equalTo: backView1.leadingAnchor),
			blurView1.trailingAnchor.constraint(equalTo: backView1.trailingAnchor),
			blurView1.topAnchor.constraint(equalTo: backView1.topAnchor),
			blurView1.bottomAnchor.constraint(equalTo: backView1.bottomAnchor),
			
			descriptionLabel.leadingAnchor.constraint(equalTo: backView1.leadingAnchor, constant: 10),
			descriptionLabel.trailingAnchor.constraint(equalTo: backView1.trailingAnchor, constant: -10),
			descriptionLabel.topAnchor.constraint(equalTo: backView1.topAnchor, constant: 10),
			descriptionLabel.bottomAnchor.constraint(equalTo: backView1.bottomAnchor, constant: 10),

			backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backView.heightAnchor.constraint(equalToConstant: 120),
			backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			blurView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
			blurView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
			blurView.topAnchor.constraint(equalTo: backView.topAnchor),
			blurView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
			
			button.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
			button.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
			button.heightAnchor.constraint(equalToConstant: 50),
			button.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -40),
		]
		
		NSLayoutConstraint.activate(constraints)
    }


}

extension StartViewController: StartViewProtocol {
	@objc func buttonAction(sender: UIButton) {
		presenter?.buttonAction()
	}
}

