//
//  MainPresenter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol

    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    
	func viewDidLoaded() {
        
        Task {
            await interactor.load()
        }
	}

//	func viewDidLoad(with result: Result<RMCharacterInfoModel, Error>) {
//
//		switch result {
//
//		case .success(let characters):
//			interactor.rmInfo = characters.info
//			guard let results = characters.results else {
//                return
//            }
//			view?.show(characters: results)
//
//		case .failure(let error):
//			view?.show(error: error)
//		}
//	}
    
    func viewDidLoad(with characters: RMCharacterInfoModel) {
        
        guard let results = characters.results else { // FIXME: Пользователь будет в шоке(((
            return
        }
        
        view?.show(characters: results)
    }

    func viewDidLoad(with error: Error) { // FIXME: Нормально?
        
        view?.show(error: error)
    }

    // FIXME: Стоит ли возращать UIImage опционалным?
    func imageDidLoaded(with url: String?, completion: @escaping ((UIImage) -> Void)) {
        guard let url else {
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                completion(image) // FIXME: И что это такое?
            }
            return
        }

        Task { // FIXME: В какой прослойке необходимо писать TASK?
            await interactor.loadImage(with: url, completion: completion)
        }
    }
    
    func imageDidLoad(with result: Result<UIImage, Error>, completion: @escaping ((UIImage) -> Void)) {
        
        switch result {
            
        case .success(let image):
            completion(image)
            
        case .failure(let error):
            print(error.localizedDescription)
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                
                completion(image)
            }
        }
    }

	func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect) {
		router.show(character: character, originFrame: originFrame)
	}
}

// FIXME: в конце файла 2 строки?
