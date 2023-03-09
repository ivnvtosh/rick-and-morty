//
//  MainCellModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 09.03.2023.
//

import UIKit

class MainCellModel: MainBaseCellModel {

    override var identifier: String {
        
        "MainCollectionViewCell"
    }
    
    var name: String
    var description: String
    var imageURL: URL?
    var color: UIColor?
    
    var image: UIImage?
    
    init(_ character: CharacterEntity) {
        
        name = character.name
        description = character.status.rawValue + " - " + character.species
        imageURL = URL(string: character.image)
        color = UIColor(named: character.getStatusPathForImage())
        
        image = character.uiimage
    }
}
