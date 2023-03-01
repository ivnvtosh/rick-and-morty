//
//  RMLocationInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMLocationInfoModel
struct RMLocationInfoModel: Codable {
    let info: RMInfoModel?
    let results: [RMLocationModel]?
}
