//
//  MainInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?

	let rmClient = RickAndMortyService()
	var rmInfo: RMInfoModel?

    let imageService = ImageService()


    func load() async {
        do {
            if let next = rmInfo?.next {
                
                let сharacters = try await rmClient.getCharacters(page: next)
                rmInfo = сharacters.info
                self.presenter?.viewDidLoad(with: сharacters)
            }
            
            else {
                
                let сharacters = try await rmClient.getCharacters()
                rmInfo = сharacters.info
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

