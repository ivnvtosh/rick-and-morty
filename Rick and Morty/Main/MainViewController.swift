//
//  MainViewController.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

protocol MainViewProtocol: AnyObject {
	func show(characters: [RMCharacterModel])
	func show(error: Error)
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

	var characters = [RMCharacterModel]()

	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
		layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 200)

		let frame = view.frame
		let length = CGFloat.minimum(frame.width, frame.height) / 2 - 25
		layout.itemSize = CGSize(width: length, height: length * 1.5)

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = UIColor(named: "ColorDeafult")

		collectionView.register(
			HeaderCollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: HeaderCollectionReusableView.identifier
		)

		collectionView.register(
			CollectionViewCell.self,
			forCellWithReuseIdentifier: CollectionViewCell.identifier
		)

		view.addSubview(collectionView)

		let refreshControl = UIRefreshControl()
		refreshControl.tintColor = .systemPink
		refreshControl.backgroundColor = .white
		refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
		
		collectionView.addSubview(refreshControl)
		return collectionView
	}()
	
	@objc func refresh(_ sender: AnyObject) {
		print("Refreshed!")
	}

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		presenter?.viewDidLoaded()
    }

	override func viewDidLayoutSubviews() {
		let frame = view.bounds
		collectionView.frame = frame
	}
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return characters.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.show(character: characters[indexPath.item])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let header = collectionView.dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: HeaderCollectionReusableView.identifier,
			for: indexPath
		) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
		return header
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.last == characters.count - 1 {
			presenter?.viewDidLoaded()
		}
	}
}

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

		DispatchQueue.main.async {
			self.present(alertController, animated: true)
		}
	}

	func show(characters: [RMCharacterModel]) {
		DispatchQueue.main.async {
			self.characters += characters
			self.collectionView.reloadData()
		}
	}
}

