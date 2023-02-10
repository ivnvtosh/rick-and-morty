//
//  StartPresenter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 08.02.2023
//

protocol StartPresenterProtocol: AnyObject {
	func buttonAction()
}

class StartPresenter {
    weak var view: StartViewProtocol?
    var router: StartRouterProtocol
    var interactor: StartInteractorProtocol

    init(interactor: StartInteractorProtocol, router: StartRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension StartPresenter: StartPresenterProtocol {
	func buttonAction() {
		router.OpenMainScrean()
	}
}

