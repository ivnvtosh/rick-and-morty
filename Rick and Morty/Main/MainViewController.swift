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

	let transition = MainAnimator()


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
			CollectionViewCell.self,
			forCellWithReuseIdentifier: CollectionViewCell.identifier
		)

		view.addSubview(collectionView)
		return collectionView
	}()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		presenter?.viewDidLoaded()
    }

	override func viewDidLayoutSubviews() {
		let frame = view.bounds
		collectionView.frame = frame
	}
	
	let interactionControllerForDismissal = SwipeDownToDismissInteractiveTransition()
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell,
			  let selectedCellSuperview = selectedCell.superview
			else {
			return
		}
		transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
		presenter?.didSelectItemAt(character: characters[indexPath.item])
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.last == characters.count - 1 {
			presenter?.viewDidLoaded()
		}
	}
}

class SwipeDownToDismissInteractiveTransition: UIPercentDrivenInteractiveTransition {
	var hasStarted = false
	var shouldFinish = false
}

// MARK: - UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		transition.isPresented = true
		return transition
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		transition.isPresented = false
		return transition
	}
	
	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
		-> UIViewControllerInteractiveTransitioning? {
		return interactionControllerForDismissal.hasStarted ? interactionControllerForDismissal : nil
	}
}

// MARK: - MainViewProtocol
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

