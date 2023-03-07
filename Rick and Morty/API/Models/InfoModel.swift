//
//  RMInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

// FIXME: В моделях никаких сокращений
// FIXME: Описать все свойства
struct InfoModel: Codable {
    
    let count: Int
    
    let pages: Int
    
    let next: String?
    
    let prev: String?
}
