//
//  CharacterInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 15.02.2023
//

class CharacterInteractor: CharacterInteractorProtocol {
    weak var presenter: CharacterPresenterProtocol?

    let imageService = ImageService()

    func loadImage(with url: String) async {
        do {
            let image = try await imageService.load(with: url)
            self.presenter?.imageDidLoad(with: .success(image))
        }
        
        catch {
            self.presenter?.imageDidLoad(with: .failure(error))
        }
    }
}

