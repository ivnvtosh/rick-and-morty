//
//  CharacterPresenter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 15.02.2023
//

import UIKit

class CharacterPresenter {
    weak var view: CharacterViewProtocol?
    var router: CharacterRouterProtocol
    var interactor: CharacterInteractorProtocol

    init(interactor: CharacterInteractorProtocol, router: CharacterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CharacterPresenter: CharacterPresenterProtocol {
    func imageDidLoaded(with url: String?) {
        guard let url else {
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                view?.show(image: image)
            }
            return
        }

        Task {
            await interactor.loadImage(with: url)
        }
    }
    
    func imageDidLoad(with result: Result<UIImage, Error>) {
        switch result {
        case .success(let image):
            view?.show(image: image)
        case .failure(let error):
            print(error.localizedDescription)
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                view?.show(image: image)
            }
        }
    }
}

