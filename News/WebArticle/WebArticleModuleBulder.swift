//
//  WebArticleModuleBulder.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

class WebArticleModuleBuilder {
    static func build(url: String) -> WebArticleViewController {
        let interactor = WebArticleInteractor(url: url)
        let router = WebArticleRouter()
        let presenter = WebArticlePresenter(router: router, interactor: interactor)
        let viewController = WebArticleViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
