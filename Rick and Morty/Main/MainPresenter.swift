//
//  MainPresenter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
	func viewDidLoaded()
	func viewDidLoad(with result: Result<RMCharacterInfoModel, Error>)

	func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect)
}

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
		interactor.load()
	}

	func viewDidLoad(with result: Result<RMCharacterInfoModel, Error>) {
		switch result {
		case .success(let characters):
			interactor.rmInfo = characters.info
			guard let results = characters.results else { return }
			view?.show(characters: results)
		case .failure(let error):
			view?.show(error: error)
		}
	}

	func didSelectItemAt(character: RMCharacterModel, originFrame: CGRect) {
		router.show(character: character, originFrame: originFrame)
	}
}

