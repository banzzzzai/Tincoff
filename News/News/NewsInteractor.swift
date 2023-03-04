//
//  NewsInteractor.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol NewsInteractorProtocol: AnyObject {
    func fetchStoredData()
    func fetchNewData(page: Int)
    func updateViewsCounter(for url: String)
    func checkInternetConnectivity() -> Bool
}

class NewsInteractor: NewsInteractorProtocol {
    weak var presenter: NewsPresenterProtocol?
    
}

extension NewsInteractor {
    
    func fetchStoredData() {
        CoreDataManager.shared.fetchAllArticles { [weak self] articles in
            self?.presenter?.dataFetched(articles: articles)
        }
    }
    
    func fetchNewData(page: Int) {
        DispatchQueue.global().async {
            NetworkManager.shared.getNews(page: page) {
                CoreDataManager.shared.fetchAllArticles { [weak self] articles in
                    self?.presenter?.dataFetched(articles: articles)
                }
            }
        }
    }
    
    func updateViewsCounter(for url: String) {
        CoreDataManager.shared.updateViewsCounter(with: url)
    }
    
    func checkInternetConnectivity() -> Bool {
        return NetworkManager.shared.connectedToNetwork()
    }
    
}
