//
//  DetailedNewsModuleBuilder.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

class DetailedNewsModuleBuilder {
    static func build(article: Article) -> DetailedNewsViewController {
        let interactor = DetailedNewsInteractor(article: article)
        let router = DetailedNewsRouter()
        let presenter = DetailedNewsPresenter(router: router, interactor: interactor)
        let viewController = DetailedNewsViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
