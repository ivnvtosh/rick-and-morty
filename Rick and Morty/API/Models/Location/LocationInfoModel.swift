//
//  RMLocationInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct LocationInfoModel: Codable {
    
    let info: InfoModel
    
    let results: [LocationModel]
}
