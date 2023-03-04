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
    var interactor: MainInteractorInput
    // FIXME: Тут сделтать двойной отступ. Двойной отступ впринципе делают?
    
    init(interactor: MainInteractorInput, router: MainRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterInput {
    
    func viewDidLoad() {
        
        // FIXME: main?
        Task { @MainActor in
            
            do {
                
                let characters = try await interactor.loadCharacter()
                
                await self.view?.showCharacters(characters)
            }
            
            catch {
                
                view?.showError(error)
            }
        }
    }
    
    func imageDidLoad(with url: String, completion: @escaping ((UIImage) async -> Void)) {
        
        Task { @MainActor in
            
            do {
                
                let image = try await interactor.loadImage(with: url)
                
                await completion(image)
            }
            
            catch {
                
                print(error.localizedDescription)
                
                await completion(UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") ?? .remove)
            }

        }
    }
    
    func didSelectItemAt(character: CharacterEntity, originFrame: CGRect) {
        
        router.showCharacter(character, originFrame: originFrame)
    }
}

extension MainPresenter: MainPresenterOutput {
    
}
