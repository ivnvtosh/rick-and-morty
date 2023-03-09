//
//  MainRouterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import Foundation

protocol MainRouterProtocol {
    
    func show(_ character: CharacterEntity)
    
    func show(_ error: Error)
	func show(_ error: Error, and loadCharaters: @escaping () -> ())
}
