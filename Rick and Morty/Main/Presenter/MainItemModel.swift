//
//  MainItemModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 09.03.2023.
//

import Foundation

class MainItemModel  {
    
    let item: CellIdentifiable
    
    var model: CellIdentifiable? {
        
        didSet {
            
            updateViews()
        }
    }
    
    init(_ character: CharacterEntity) {
        
        item = MainCellModel(character)
    }
    
    func updateViews() { }
}
