//
//  MainPresenter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

final class MainPresenter {
    
    weak var view: MainViewInput?
    var interactor: MainInteractorInput
    var router: MainRouterProtocol
    
	init(view: MainViewInput,
         interactor: MainInteractorInput,
         router: MainRouterProtocol) {
        
		self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainViewOutput {
    
    func viewDidLoad() {
        
        Task { @MainActor in
            
            do {
                
                let characters = try await interactor.loadCharacter()
                
                await self.view?.show(characters)
            }
            
            catch {
                
                router.show(error)
            }
        }
    }
    
	// FIXME: Событие
    func didDisplayCell(with url: String, completion: @escaping ((UIImage) async -> Void)) {
        
        Task { @MainActor in
            
            do {
                
                let image = try await interactor.loadImage(with: url)
                
                await completion(image)
            }
            
            catch {
                
                print(error.localizedDescription)
                
				let systemName = "externaldrive.trianglebadge.exclamationmark"
				let image = UIImage(systemName: systemName) ?? .remove
				
				await completion(image)
            }
        }
    }
    
    func didSelectItemAt(character: CharacterEntity, originFrame: CGRect) {
        
        router.show(character, originFrame: originFrame)
    }
    
    func willDisplayCell() {
        
        Task { @MainActor in
            
            do {
                
                let characters = try await interactor.loadCharacterNext()
                
                await self.view?.show(characters)
            }
            
            catch {
                
                router.show(error)
            }
        }
    }
}

extension MainPresenter: MainInteractorOutput { }
