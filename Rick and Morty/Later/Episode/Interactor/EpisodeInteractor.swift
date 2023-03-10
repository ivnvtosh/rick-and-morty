//
//  EpisodeInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol EpisodeInteractorProtocol: AnyObject {
	func load()

	var rmInfo: InfoModel? { get set }
}

class EpisodeInteractor: EpisodeInteractorProtocol {
    weak var presenter: EpisodePresenterProtocol?

	let rmClient = RickAndMortyService()
	var rmInfo: InfoModel?


	func load() {
//		if let next = rickAndMortyInfo?.next {
//			rickAndMortyService.getEpisodes(page: next) { result in
//				self.presenter?.viewDidLoad(with: result)
//			}
//
//		} else {
//			rmClient.getEpisodes { result in
//				self.presenter?.viewDidLoad(with: result)
//			}
//		}
	}
}

