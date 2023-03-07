//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewOutput?
    
    var characters = [CharacterEntity]()
    
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
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraint()
        presenter?.viewDidLoad()
    }
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                            for: indexPath) as? MainCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.item]
        
        cell.show(character: character)
		
        presenter?.didDisplayCell(with: character.image, completion: cell.show)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        // FIXME: Если не сработает, то что делать?
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell,
              let selectedCellSuperview = selectedCell.superview else {

            return
        }
        
        let originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        
        presenter?.didSelectItemAt(character: characters[indexPath.item], originFrame: originFrame)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if indexPath.last == characters.count - 1 {
            
            presenter?.willDisplayCell()
        }
    }
}

extension MainViewController: MainViewInput {
    
    func show(_ characters: [CharacterEntity]) async {
        
        self.characters += characters
        self.collectionView.reloadData()
    }
}
