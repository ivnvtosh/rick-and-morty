//
//  MainViewController.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewOutput?
    
    var items = [MainItemModel]()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 40
        
        let length = view.frame.width - 120
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
        
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = items[indexPath.item].item
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier,
                                                            for: indexPath) as? MainBaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.model = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let cellAction = presenter as? MainCollectionViewDelegate
        let index = indexPath.item
        
        cellAction?.didSelectItem(at: index)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if indexPath.last == items.count - 1 {
            
            let cellAction = presenter as? MainCollectionViewDelegate
            cellAction?.willDisplayLastItem()
        }
    }
}

extension MainViewController: MainViewInput {
    
    func show(_ items: [MainItemModel]) async {
        
        self.items += items
        collectionView.reloadData()
    }
}
