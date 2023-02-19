//
//  CharacterViewController.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 15.02.2023
//

import UIKit

protocol CharacterViewProtocol: AnyObject {
	func show(character: RMCharacterModel)
}

class CharacterViewController: UIViewController {
    var presenter: CharacterPresenterProtocol?

	var interactionController: UIPercentDrivenInteractiveTransition?
	var edgeSwipeGestureRecognizer: UIScreenEdgePanGestureRecognizer?
	
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		
		imageView.translatesAutoresizingMaskIntoConstraints = false

//		imageView.contentMode = .
		imageView.backgroundColor = .red
		view.addSubview(imageView)
		return imageView
	}()
	
	@objc private func handlePan(_ sender: UIPanGestureRecognizer) {
		switch sender.state {
			case.ended:
				dismiss(animated: true)
			default:
				break
		}
	}
	
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		let panGestureRecognizer = UIPanGestureRecognizer()
		panGestureRecognizer.addTarget(self, action: #selector(handlePan))
		view.addGestureRecognizer(panGestureRecognizer)

		let constraint = [
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: view.frame.width),
		]
		NSLayoutConstraint.activate(constraint)
		
		setupView()
    }

	// MARK: - View Methods
	private func setupView() {
		view.backgroundColor = UIColor(named: "ColorDeafult")
	}

	private func show(imageURL: String?) {
		guard let imageURL else { return }

		if let cachedImage = Cache.imageCache.object(forKey: imageURL as NSString) {
			DispatchQueue.main.async {
				self.imageView.image = cachedImage
			}
//			activityIndicatorView.stopAnimating()
//			activityIndicatorView.isHidden = true
			return
		}

		guard let url = URL(string: imageURL) else { return }
//		imageIdentifier = imageURL

		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: url)
				
				guard let image = UIImage(data: data) else { return }
				
				Cache.imageCache.setObject(image, forKey: imageURL as NSString)
				
				DispatchQueue.main.async { [weak self] in
//					if self?.imageIdentifier == imageURL {
						self?.imageView.image = image
//						self?.activityIndicatorView.stopAnimating()
//						self?.activityIndicatorView.isHidden = true
//					}
				}
			}
			
			catch (let error) {
				print(error.localizedDescription)
				DispatchQueue.main.async { [weak self] in
//					if self?.imageIdentifier == imageURL {
						self?.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
//						self?.activityIndicatorView.stopAnimating()
//						self?.activityIndicatorView.isHidden = true
//					}
				}
			}
		}
	}
}

// MARK: - CharacterViewProtocol
extension CharacterViewController: CharacterViewProtocol {
	func show(character: RMCharacterModel) {
		show(imageURL: character.image)
	}
}

