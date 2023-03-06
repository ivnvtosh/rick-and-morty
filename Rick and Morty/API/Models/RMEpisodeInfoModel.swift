//
//  RMEpisodeInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

struct RMEpisodeInfoModel: Codable {
    
    let info: RMInfoModel?
    
    let results: [RMEpisodeModel]?
    
    
    enum CodingKeys: CodingKey {
        
        case info
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.info, forKey: .info)
        try container.encodeIfPresent(self.results, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.info = try container.decodeIfPresent(RMInfoModel.self, forKey: .info)
        self.results = try container.decodeIfPresent([RMEpisodeModel].self, forKey: .results)
    }
}
