//
//  MainInteractorProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainInteractorProtocol: AnyObject {
    var rmInfo: RMInfoModel? { get set }

    func load() async

    func loadImage(with url: String, completion: @escaping ((UIImage) -> Void)) async
}
