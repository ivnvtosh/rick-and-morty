//
//  LocationPresenter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol LocationPresenterProtocol: AnyObject {
	func viewDidLoaded()
	func viewDidLoad(with result: Result<RMLocationInfoModel, Error>)
}

class LocationPresenter {
    weak var view: LocationViewProtocol?
    var router: LocationRouterProtocol
    var interactor: LocationInteractorProtocol

    init(interactor: LocationInteractorProtocol, router: LocationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension LocationPresenter: LocationPresenterProtocol {
	func viewDidLoaded() {
		interactor.load()
	}
	
	func viewDidLoad(with result: Result<RMLocationInfoModel, Error>) {
		switch result {
		case .success(let locations):
			interactor.rmInfo = locations.info
			guard let results = locations.results else { return }
			view?.show(locations: results)
		case .failure(let error):
			view?.show(error: error)
		}
	}
}

