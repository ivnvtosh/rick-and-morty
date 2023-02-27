//
//  CharacterViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 15.02.2023
//

import UIKit

class CharacterViewController: UIViewController {
    var presenter: CharacterPresenterProtocol?
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "ColorCell")
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.addTarget(self, action: #selector(handlePan))
        view.addGestureRecognizer(panGestureRecognizer)
        
        setupView()
        setupConstraint()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) { [self] in
            let scaleY = view.frame.width / view.frame.height
            let shiftY = (view.frame.width - view.frame.height) / 2
            var transform = CGAffineTransform(translationX: 0, y: shiftY)
            transform = transform.scaledBy(x: 1, y: scaleY)
            self.imageView.layer.cornerRadius = 0.0
            self.imageView.transform = transform
            
            self.nameLabel.transform = CGAffineTransform(translationX: 0, y: -view.frame.height + view.frame.width + 200)
            self.descriptionLabel.transform = CGAffineTransform(translationX: 0, y: -view.frame.height + view.frame.width + 200)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.imageView.transform = .identity
            self.nameLabel.transform = .identity
            self.descriptionLabel.transform = .identity
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "ColorDeafult")
    }
    
    private func setupConstraint() {
        let constraint = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ]

        NSLayoutConstraint.activate(constraint)
    }

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case.ended:
            dismiss(animated: true)
        default:
            break
        }
    }
}

// MARK: - CharacterViewProtocol

extension CharacterViewController: CharacterViewProtocol {
	func show(character: RMCharacterModel) {
        presenter?.imageDidLoaded(with: character.image) // FIXME: VIPER
		DispatchQueue.main.async {
			self.nameLabel.text = character.name
			self.descriptionLabel.text = (character.status?.rawValue ?? "") + " - " + (character.species ?? "")
		}
	}

    func show(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
        }
    }
}

