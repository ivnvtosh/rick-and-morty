//
//  RMEpisodeInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// MARK: - RMEpisodeInfoModel
struct RMEpisodeInfoModel: Codable {
    let info: RMInfoModel?
    let results: [RMEpisodeModel]?
}
