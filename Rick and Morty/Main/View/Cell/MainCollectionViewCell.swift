//
//  MainCollectionViewCell.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 14.11.2022.
//

import UIKit

final class MainCollectionViewCell: MainBaseCollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    
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
    
    private func setupView() {
        
        contentView.backgroundColor = UIColor(named: "ColorCell")
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
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
        ])
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
    }
        
    override func updateViews() {
        
        guard let model = model as? MainCellModel else {
            
            return
        }
        
        Task { @MainActor in
            
            nameLabel.text = model.name
            
            descriptionLabel.text = model.description
            
            statusImageView.tintColor = model.color
            
            imageView.image = model.image
        }
    }
    
//    public func show(image: UIImage) async {
//
//        activityIndicatorView.stopAnimating()
//        activityIndicatorView.isHidden = true
//
//        imageView.image = image
//    }
}

