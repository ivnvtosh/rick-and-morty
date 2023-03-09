//
//  MainCollectionViewDelegate.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 09.03.2023.
//

import UIKit

protocol MainCollectionViewDelegate {
    
    func didSelectItem(at index: Int)
    func didDisplayItem(at index: Int)
    func willDisplayLastItem()
}
