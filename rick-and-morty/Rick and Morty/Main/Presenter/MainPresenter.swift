//
//  MainPresenter.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 13.11.2022
//

import UIKit

class MainPresenter {
    
    weak var view: MainViewProtocol?
    // FIXME: Тут нужен отступ?
    var router: MainRouterProtocol
    // FIXME: Тут нужен отступ?
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
}

// !!!
// FIXME: У меня используется такая связь:
// view говорит презентару, что нужно отобразить картинку: из view вызываем presenter.viewDidLoaded()
// presenter говорит интерактору, что нужно получить картинку: из презентара вызываем interactor.load()
// интерактор обращается к сервису и получает картинку, а после вызывает презентер, чтобы тот решил с что ней  делать: из интерактора вызываем presenter.viewDidLoad(with: image) (интераткор должен отлавливать ошибку)
// презентер говорит view, что отобрази данные: из презентара вызываем view.show(image)
// !!!

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoaded() {
        
        // FIXME: В какой прослойке необходимо писать TASK?
        Task {
            await interactor.load()
        }
    }
    
    func viewDidLoad(with characters: RMCharacterInfoModel) {
        
        guard let results = characters.results else { // FIXME: Пользователь будет в шоке((( Модел в интерактор и проблема решится
            return
        }

        Task {
            await self.view?.show(characters: results)
        }
    }
    
    func viewDidLoad(with error: Error) { // FIXME: Нормально?
        
        view?.show(error: error)
    }

    // FIXME: Стоит ли возращать UIImage опционалным? Думаю нет
    func imageDidLoaded(with url: String?, completion: @escaping ((UIImage) -> Void)) {
        
        guard let url else {
            
            if let image = UIImage(systemName: "externaldrive.trianglebadge.exclamationmark") {
                completion(image) // FIXME: И что это такое?
            }
            
            return
        }

        Task {
            await self.interactor.loadImage(with: url, completion: completion)
        }
    }
    
    // FIXME: Проблема должна решится, когда модель уйдет в интерактор или мб в презентер и появятся сущности
    func imageDidLoad(with result: Result<UIImage, Error>, completion: @escaping ((UIImage) -> Void)) {
        
        switch result {
            
        case .success(let image):
            completion(image)
            
        case .failure(let error): // FIXME: норм отступы?
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

// FIXME: в конце файла 1 строка?
