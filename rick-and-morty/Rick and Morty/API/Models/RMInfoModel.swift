//
//  RMInfoModel.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 01.03.2023.
//

import Foundation // FIXME: тут это очевидно, удаляю? и в протоколах?

// MARK: - RMInfoModel
struct RMInfoModel: Codable {
    // Нужен отступ
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
