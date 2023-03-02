//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol?
    
    // FIXME: rename
    let rmClient = RickAndMortyService()
    var rmInfo: RMInfoModel?
    
    let imageService = ImageService()
    
    
    func load() async {
        
        do {
            
            // FIXME: разбить на 2 метода
            if let nextPage = rmInfo?.next {
                
                let сharacters = try await rmClient.getCharacters(from: nextPage)
                
                rmInfo = сharacters.info
                
                self.presenter?.viewDidLoad(with: сharacters)
            }
            
            else {
                
                let сharacters = try await rmClient.getCharacters()
                
                rmInfo = сharacters.info
                
                // FIXME: сharacters.result
                self.presenter?.viewDidLoad(with: сharacters)
            }
        }
        
        catch {
            
            self.presenter?.viewDidLoad(with: error)
        }
    }
    
    func loadImage(with url: String, completion: @escaping ((UIImage) -> Void)) async {
        
        do {
            
            let image = try await imageService.load(with: url)
            
            self.presenter?.imageDidLoad(with: .success(image), completion: completion)
        }
        
        catch {
            
            self.presenter?.imageDidLoad(with: .failure(error), completion: completion)
        }
    }
}
