//
//  LocationCollectionViewCell.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
	static let identifier = "CollectionViewCell"

	var imageIdentifier = ""


	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(imageView)
		return imageView
	}()

	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(label)
		return label
	}()

	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(label)
		return label
	}()

	lazy var activityIndicatorView: UIActivityIndicatorView = {
		let activityIndicatorView = UIActivityIndicatorView()
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
		activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(activityIndicatorView)
		return activityIndicatorView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
		setupConstraint()
	}
	
	func setupView() {
		contentView.backgroundColor = UIColor(named: "ColorCell")
		contentView.layer.cornerRadius = 15
		contentView.clipsToBounds = true
	}
	
	func setupConstraint() {
		let constraint = [
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

			nameLabel.heightAnchor.constraint(equalToConstant: 40),
			nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			
			descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
			descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
			descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
		]
		
		NSLayoutConstraint.activate(constraint)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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

//		if let cachedImage = Cache.imageCache.object(forKey: imageURL as NSString) {
//			imageView.image = cachedImage
//			activityIndicatorView.stopAnimating()
//			activityIndicatorView.isHidden = true
//			return
//		}

		guard let url = URL(string: imageURL) else { return }
		imageIdentifier = imageURL

		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: url)
				
				guard let image = UIImage(data: data) else { return }
				
//				Cache.imageCache.setObject(image, forKey: imageURL as NSString)
				
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

	public func show(locations: RMLocationModel) {
		nameLabel.text = locations.name
//		descriptionLabel.text = (character.status?.rawValue ?? "") + " - " + (character.species ?? "")

//		show(imageURL: episodes.image)
	}
}

