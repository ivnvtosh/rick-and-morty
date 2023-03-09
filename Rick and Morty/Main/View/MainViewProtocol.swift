//
//  MainViewProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainViewInput: AnyObject {
    
    func show(_ items: [MainItemModel]) async
}

protocol MainViewOutput: AnyObject {
    
    func viewDidLoad()
}
