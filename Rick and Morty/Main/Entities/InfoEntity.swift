//
//  InfoEntity.swift
//  Rick and Morty
//
//  Created by Иванов Антон Александрович on 07.03.2023.
//

struct InfoEntity {
    
    let count: Int
    
    let pages: Int
    
    let next: String?
    
    let previos: String?
    
    init(model: InfoModel) {
        
        count = model.count
        pages = model.pages
        next = model.next
        previos = model.prev
    }
}
