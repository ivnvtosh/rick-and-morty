//
//  EpisodeInteractor.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol EpisodeInteractorProtocol: AnyObject {
	func load()

	var rmInfo: RMInfoModel? { get set }
}

class EpisodeInteractor: EpisodeInteractorProtocol {
    weak var presenter: EpisodePresenterProtocol?

	let rmClient = RMClient()
	var rmInfo: RMInfoModel?


	func load() {
		if let next = rmInfo?.next {
			rmClient.getEpisodes(page: next) { result in
				self.presenter?.viewDidLoad(with: result)
			}

		} else {
			rmClient.getEpisodes { result in
				self.presenter?.viewDidLoad(with: result)
			}
		}
	}
}

