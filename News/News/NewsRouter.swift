//
//  NewsRouter.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol NewsRouterProtocol {
    
    func openDetailedInfo(for article: Article)
    
}

class NewsRouter: NewsRouterProtocol {
    weak var viewController: NewsViewController?

    func openDetailedInfo(for article: Article) {
        let vc = DetailedNewsModuleBuilder.build(article: article)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
