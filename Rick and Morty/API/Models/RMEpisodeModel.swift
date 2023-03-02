//
//  RMEpisodeModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct RMEpisodeModel: Codable {
    
    let id: Int?
    
    let name: String?
    
    let airDate: String?
    
    let episode: String?
    
    let characters: [String?]
    
    let url: String?
    
    let created: String?

    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}
