//
//  RMLocationModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct LocationModel: Codable {
    
    let id: Int
    
    let name: String
    
    let type: String
    
    let dimension: String
    
    let residents: [String]
    
    let url: String
    
    let created: String
}
