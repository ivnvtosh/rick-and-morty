//
//  MainPresenter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainPresenter {
    
    weak var view: MainViewProtocol?
    // FIXME: Тут нужен отступ?
    var router: MainRouterProtocol
    // FIXME: Тут нужен отступ?
    var interactor: MainInteractorProtocol
    // FIXME: Тут сделтать двойной отступ. Двойной отступ впринципе делают?
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        
        Task {
            
            await interactor.load()
        }
    }
    
    // FIXME: как переименовать?
    func viewDidLoad(with characters: RMCharacterInfoModel) {
        
        // FIXME: Уйдет само
        guard let results = characters.results else {
            
            return
        }
        
        Task { @MainActor in
            // FIXME: Тут нужен отступ?
            await self.view?.show(characters: results)
        }
    }
    
    // FIXME: как переименовать?
    func viewDidLoad(with error: Error) {
        
        view?.show(error: error)
    }
    
    func imageDidLoaded(with url: String?, completion: @escaping ((UIImage) -> Void)) {
        
        guard let url else {
            
            // FIXME: Переписать?
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                
                completion(image)
            }
            
            return
        }
        
        Task {
            
            await self.interactor.loadImage(with: url, completion: completion)
        }
    }
    
    // FIXME: Уйдет само
    func imageDidLoad(with result: Result<UIImage, Error>, completion: @escaping ((UIImage) -> Void)) {
        
        switch result {
            
        case .success(let image):
            completion(image)
            
        case .failure(let error):
            print(error.localizedDescription)
            
            // FIXME: Переписать?
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                
                completion(image)
            }
        }
    }
    
    func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect) {
        
        router.show(character: character, originFrame: originFrame)
    }
}
