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
    
    private func loadCharacters() {
        
        Task { @MainActor in

            do {

                let characters = try await interactor.loadCharacter()
                
                let items = characters.map() { MainItemModel($0) }
                
                await view?.show(items)
            }

            catch {

                router.show(error, and: loadCharacters)
            }
        }
    }

    private func loadNextCharacters() {

        Task { @MainActor in

            do {

                let characters = try await interactor.loadNextCharacters()

                let charactersWithImage = characters.map() { character in
                    
                    var character = character
                    
                    Task { @MainActor in
                        character.uiimage = await loadImage(from: character.image)
                    }
                    return character
                }
                
                let items = charactersWithImage.map() { MainItemModel($0) }
                
                await view?.show(items)
            }

            catch {

                router.show(error)
            }
        }
    }
    
    private func loadImage(from url: String) async -> UIImage {
        
        do {

            return try await interactor.loadImage(with: url)
        }
        
        catch {
            
            print(error.localizedDescription)
            
            let systemName = "externaldrive.trianglebadge.exclamationmark"
            let image = UIImage(systemName: systemName) ?? .remove
            
            return image
        }
    }
}

extension MainPresenter: MainCollectionViewDelegate {
    
    func didSelectItem(at index: Int) {
        
        guard let character = interactor.characterEntity?[index] else {
            
            return
        }
        
        router.show(character)
    }
    
    func willDisplayLastItem() {
        
        loadNextCharacters()
    }
    
    func didDisplayItem(at index: Int) {

//        guard let character = interactor.characterEntity?[index] else {
//
//            return
//        }
//
//        loadImage(from: character.image)
    }
}

extension MainPresenter: MainViewOutput {
    	
    func viewDidLoad() {
        
		loadCharacters()
    }
}

extension MainPresenter: MainInteractorOutput { }
