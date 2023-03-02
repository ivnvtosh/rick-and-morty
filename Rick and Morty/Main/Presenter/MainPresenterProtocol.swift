//
//  MainPresenterProtocol.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func viewDidLoad(with characters: RMCharacterInfoModel)
    
    func viewDidLoad(with error: Error)
    
    // FIXME: Так?
    func imageDidLoaded(with url: String?,
                        completion: @escaping ((UIImage) -> Void))
    // FIXME: Или тик так?
    func imageDidLoad(
        with result: Result<UIImage, Error>,
        completion: @escaping ((UIImage) -> Void))
    
    func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect)
}
