//
//  DetailedNewsRouter.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol DetailedNewsRouterProtocol {
    func openWebPage(with url: String)
}

class DetailedNewsRouter: DetailedNewsRouterProtocol {
    weak var viewController: DetailedNewsViewController?

    func openWebPage(with url: String) {
        let vc = WebArticleModuleBuilder.build(url: url)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
