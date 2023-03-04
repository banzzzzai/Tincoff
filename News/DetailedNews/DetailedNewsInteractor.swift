//
//  DetailedNewsInteractor.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol DetailedNewsInteractorProtocol: AnyObject {
    func loadData()
    func checkInternetConnectivity() -> Bool
}

class DetailedNewsInteractor: DetailedNewsInteractorProtocol {
    weak var presenter: DetailedNewsPresenterProtocol?
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
}

extension DetailedNewsInteractor {
    
    func loadData() {
        presenter?.dataDidLoad(article: article)
    }
    
    func checkInternetConnectivity() -> Bool {
        return NetworkManager.shared.connectedToNetwork()
    }
    
}
