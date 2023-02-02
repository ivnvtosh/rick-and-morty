//
//  MainFilterCell.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 20.11.2022.
//

import UIKit

class MainFilterCollectionViewCell: UICollectionViewCell {
	static let identifier = "MainFilterCollectionViewCell"

	lazy var label: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = UIColor(named: "ColorDeafult")
		label.font = UIFont.boldSystemFont(ofSize: 16)
		contentView.addSubview(label)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.backgroundColor = UIColor(named: "RMColorOrange")
		contentView.layer.cornerRadius = 20
		contentView.clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let frame = contentView.bounds

		label.frame = CGRect(
			x: 0,
			y: 0,
			width: frame.width,
			height: frame.height
		)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		
		isHidden = false
		isSelected = false
		isHighlighted = false
	}

	func show(text: String) {
		label.text = text
	}
}
