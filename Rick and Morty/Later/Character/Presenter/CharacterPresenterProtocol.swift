//
//  CharacterPresenterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol CharacterPresenterProtocol: AnyObject {
    func imageDidLoaded(with url: String?)
    func imageDidLoad(with result: Result<UIImage, Error>)
}
