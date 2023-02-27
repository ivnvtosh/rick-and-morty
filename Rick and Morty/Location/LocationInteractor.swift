//
//  LocationInteractor.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 27.02.2023
//

protocol LocationInteractorProtocol: AnyObject {
	func load()

	var rmInfo: RMInfoModel? { get set }
}

class LocationInteractor: LocationInteractorProtocol {
    weak var presenter: LocationPresenterProtocol?


	let rmClient = RMClient()
	var rmInfo: RMInfoModel?

	func load() {
		if let next = rmInfo?.next {
			rmClient.getLocations(page: next) { result in
				self.presenter?.viewDidLoad(with: result)
			}

		} else {
			rmClient.getLocations { result in
				self.presenter?.viewDidLoad(with: result)
			}
		}
	}
}

