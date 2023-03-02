//
//  LocationViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023
//

import UIKit

protocol LocationViewProtocol: AnyObject {
	func show(locations: [RMLocationModel])
	func show(error: Error)
}

class LocationViewController: UIViewController {
    var presenter: LocationPresenterProtocol?

	var locations = [RMLocationModel]()


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
			LocationCollectionViewCell.self,
			forCellWithReuseIdentifier: LocationCollectionViewCell.identifier
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

	func setupConstraint() {
		let constraint = [
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		]

		NSLayoutConstraint.activate(constraint)
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension LocationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return locations.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.show(locations: locations[indexPath.item])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.last == locations.count - 1 {
			presenter?.viewDidLoaded()
		}
	}
}

extension LocationViewController: LocationViewProtocol {
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

	func show(locations: [RMLocationModel]) {
		DispatchQueue.main.async {
			self.locations += locations
			self.collectionView.reloadData()
		}
	}
}

