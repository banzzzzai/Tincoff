//
//  NewsModuleBuilder.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

class NewsModuleBuilder {
    static func build() -> NewsViewController {
        let interactor = NewsInteractor()
        let router = NewsRouter()
        let presenter = NewsPresenter(router: router, interactor: interactor)
        let viewController = NewsViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
