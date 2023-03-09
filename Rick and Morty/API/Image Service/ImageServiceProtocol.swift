//
//  ImageServiceProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanon on 09.03.2023.
//

import UIKit

protocol ImageServiceProtocol {
    
    func load(with url: String) async throws -> UIImage
}
