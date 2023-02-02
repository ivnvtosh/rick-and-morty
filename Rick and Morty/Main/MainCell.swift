//
//  CollectionViewCell.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 14.11.2022.
//

import UIKit

class Cache {
	static let imageCache = NSCache<NSString, UIImage>()
}

class CollectionViewCell: UICollectionViewCell {
	static let identifier = "CollectionViewCell"

	var imageIdentifier = ""

	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		contentView.addSubview(imageView)
		return imageView
	}()

	lazy var nameLabel: UILabel = {
		let label = UILabel()
		contentView.addSubview(label)
		return label
	}()

	lazy var statusImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "circle.fill")
		imageView.tintColor = .gray
		contentView.addSubview(imageView)
		return imageView
	}()

	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		contentView.addSubview(label)
		return label
	}()

	lazy var activityIndicatorView: UIActivityIndicatorView = {
		let activityIndicatorView = UIActivityIndicatorView()
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
		contentView.addSubview(activityIndicatorView)
		return activityIndicatorView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.backgroundColor = UIColor(named: "ColorCell")
		contentView.layer.cornerRadius = 15
		contentView.clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let frame = contentView.bounds

		imageView.frame = CGRect(
			x: 0,
			y: 0,
			width: frame.width,
			height: frame.width
		)

		statusImageView.frame = CGRect(
			x: 15,
			y: imageView.frame.width + 8 + 20 + 5 + 5,
			width: 10,
			height: 10
		)

		nameLabel.frame = CGRect(
			x: 15,
			y: imageView.frame.width + 8,
			width: frame.width - 30,
			height: 20
		)

		descriptionLabel.frame = CGRect(
			x: 35,
			y: imageView.frame.width + 8 + 20 + 5,
			width: frame.width - 30,
			height: 20
		)

		activityIndicatorView.frame = imageView.frame
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		isHidden = false
		isSelected = false
		isHighlighted = false
		imageView.image = nil
		nameLabel.text = nil
		descriptionLabel.text = nil
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
		
		imageIdentifier = ""
	}

	private func show(imageURL: String?) {
		guard let imageURL else { return }

		if let cachedImage = Cache.imageCache.object(forKey: imageURL as NSString) {
			imageView.image = cachedImage
			activityIndicatorView.stopAnimating()
			activityIndicatorView.isHidden = true
			return
		}

		guard let url = URL(string: imageURL) else { return }
		imageIdentifier = imageURL

		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: url)
				
				guard let image = UIImage(data: data) else { return }
				
				Cache.imageCache.setObject(image, forKey: imageURL as NSString)
				
				DispatchQueue.main.async { [weak self] in
					if self?.imageIdentifier == imageURL {
						self?.imageView.image = image
						self?.activityIndicatorView.stopAnimating()
						self?.activityIndicatorView.isHidden = true
					}
				}
			}
			
			catch (let error) {
				print(error.localizedDescription)
				DispatchQueue.main.async { [weak self] in
					if self?.imageIdentifier == imageURL {
						self?.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
						self?.activityIndicatorView.stopAnimating()
						self?.activityIndicatorView.isHidden = true
					}
				}
			}
		}
	}

	public func show(character: RMCharacterModel) {

		nameLabel.text = character.name
		descriptionLabel.text = (character.status?.rawValue ?? "") + " - " + (character.species ?? "")

		show(imageURL: character.image)

		switch character.status! {
		case .alive:
			statusImageView.tintColor = UIColor(named: "RMColorGreen")
		case .dead:
			statusImageView.tintColor = UIColor(named: "RMColorRed")
		case .unknown:
			statusImageView.tintColor = UIColor(named: "RMColorGray")
		case .none:
			statusImageView.tintColor = UIColor(named: "RMColorGray")
		}
	}
}

