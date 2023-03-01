//
//  MainInteractor.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 13.11.2022
//

protocol MainInteractorProtocol: AnyObject {
	func load()

	var rmInfo: RMInfoModel? { get set }
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?

	let rmClient = RMClient()
	var rmInfo: RMInfoModel?

	func load() {
		if let next = rmInfo?.next {
			rmClient.getCharacters(page: next) { result in
				self.presenter?.viewDidLoad(with: result)
			}

		} else {
			rmClient.getCharacters { result in
				self.presenter?.viewDidLoad(with: result)
			}
		}
	}
}

