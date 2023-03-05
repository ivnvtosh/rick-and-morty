//
//  LocationInteractor.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol LocationInteractorProtocol: AnyObject {
	func load()

	var rmInfo: RMInfoModel? { get set }
}

class LocationInteractor: LocationInteractorProtocol {
    weak var presenter: LocationPresenterProtocol?


	let rmClient = RickAndMortyService()
	var rmInfo: RMInfoModel?

	func load() {
//		if let next = rickAndMortyInfo?.next {
//			rickAndMortyService.getLocations(page: next) { result in
//				self.presenter?.viewDidLoad(with: result)
//			}
//
//		} else {
//			rmClient.getLocations { result in
//				self.presenter?.viewDidLoad(with: result)
//			}
//		}
	}
}

