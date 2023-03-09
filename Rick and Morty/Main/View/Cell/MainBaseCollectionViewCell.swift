//
//  MainBaseCell.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 09.03.2023.
//

import UIKit

class MainBaseCollectionViewCell: UICollectionViewCell, ModelRepresentable {
    
    var model: CellIdentifiable? {
        
        didSet {
            
            updateViews()
        }
    }
    
    func updateViews() { }
}
