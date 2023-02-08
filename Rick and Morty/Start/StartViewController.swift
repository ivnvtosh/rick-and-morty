//
//  StartViewController.swift
//  Super easy dev
//
//  Created by Anton Ivanov on 08.02.2023
//

import UIKit

protocol StartViewProtocol: AnyObject {
	
}

class StartViewController: UIViewController {
    var presenter: StartPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .red
    }


}

extension StartViewController: StartViewProtocol {
	
}

