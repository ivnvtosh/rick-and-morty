//
//  MainHeaderCollectionReusableView.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 19.11.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
	static let identifier = "HeaderCollectionReusableView"

	let filter = ["name", "status", "species", "type", "gender", "query"]

	lazy var label: UILabel = {
		let label = UILabel()
		label.text = "The Rick and Morty API"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 32)
		label.textColor = UIColor(named: "ColorDeafult")
		addSubview(label)
		return label
	}()

	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 20)

		let frame = bounds
//		let length = CGFloat.minimum(frame.width, frame.height) / 5 - 25
//		layout.itemSize = CGSize(width: length, height: length * 1.5)
		layout.itemSize = CGSize(width: 100, height: 40)

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .clear

		collectionView.register(
			MainFilterCollectionViewCell.self,
			forCellWithReuseIdentifier: MainFilterCollectionViewCell.identifier
		)

		addSubview(collectionView)
		return collectionView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		label.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: 200
		)

		collectionView.frame = CGRect(
			x: 0,
			y: 120,
			width: bounds.width,
			height: 80
		)
	}
}

extension HeaderCollectionReusableView: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filter.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFilterCollectionViewCell.identifier, for: indexPath) as? MainFilterCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.show(text: filter[indexPath.item])
		return cell
	}
}

