//
//  EpisodePresenter.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol EpisodePresenterProtocol: AnyObject {
	func viewDidLoaded()
	func viewDidLoad(with result: Result<RMEpisodeInfoModel, Error>)
}

class EpisodePresenter {
    weak var view: EpisodeViewProtocol?
    var router: EpisodeRouterProtocol
    var interactor: EpisodeInteractorProtocol

    init(interactor: EpisodeInteractorProtocol, router: EpisodeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension EpisodePresenter: EpisodePresenterProtocol {
	func viewDidLoaded() {
		interactor.load()
	}
	
	func viewDidLoad(with result: Result<RMEpisodeInfoModel, Error>) {
		switch result {
		case .success(let episodes):
			interactor.rmInfo = episodes.info
			guard let results = episodes.results else { return }
			view?.show(episodes: results)
		case .failure(let error):
			view?.show(error: error)
		}
	}
}

