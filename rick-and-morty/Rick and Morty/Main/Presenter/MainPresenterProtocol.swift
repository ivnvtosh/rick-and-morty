//
//  MainPresenterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    
    func viewDidLoaded()
    func viewDidLoad(with characters: RMCharacterInfoModel)
    @MainActor
    func viewDidLoad(with error: Error)

    func imageDidLoaded(with url: String?, completion: @escaping ((UIImage) -> Void))
    func imageDidLoad(with result: Result<UIImage, Error>,
                      completion: @escaping ((UIImage) -> Void))

    func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect)
}
