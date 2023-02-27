//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?

	var characters = [RMCharacterModel]()


    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        layout.minimumLineSpacing = 40
        
        let length = view.frame.width - 80
        layout.itemSize = CGSize(width: length, height: length)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "ColorDeafult")
        
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        return collectionView
    }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		setupView()
		setupConstraint()
		presenter?.viewDidLoaded()
    }

	func setupView() {
		
	}

	func setupConstraint() { // FIXME: Нужен отступ?
		NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
		characters.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
		guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.identifier,
            for: indexPath) as? MainCollectionViewCell else {
            
			return UICollectionViewCell()
		}

        let character = characters[indexPath.item]
        cell.show(character: character)
        presenter?.imageDidLoaded(with: character.image, completion: cell.show)

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let selectedCell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell,
			  let selectedCellSuperview = selectedCell.superview else {
            return
        }
        
		let originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
		presenter?.didSelectItemAt(character: characters[indexPath.item], originFrame: originFrame)
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
		if indexPath.last == characters.count - 1 {
			presenter?.viewDidLoaded()
		}
	}
}

// MARK: - MainViewProtocol
// FIXME: Нужен отступ?
extension MainViewController: MainViewProtocol {
    
	func show(error: Error) {
        
		let alertController = UIAlertController(
			title: "Error",
			message: error.localizedDescription,
			preferredStyle: .alert
		)

		let alertAction = UIAlertAction(
			title: "Try again",
			style: .default,
			handler: { [weak self]  _ in
				self?.presenter?.viewDidLoaded()
			}
		)

		alertController.addAction(alertAction)

		DispatchQueue.main.async { [weak self] in
			self?.present(alertController, animated: true)
		}
	}

	func show(characters: [RMCharacterModel]) {
		DispatchQueue.main.async { [weak self] in
			self?.characters += characters
			self?.collectionView.reloadData()
		}
	}
}

