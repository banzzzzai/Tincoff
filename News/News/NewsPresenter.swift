//
//  NewsPresenter.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol NewsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func dataFetched(articles: [Article]?)
    func fetchMoreData(page: Int, completion: @escaping () -> ())
    func tableViewStartedLoadingNewData()
    func didTapOnCell(with article: Article)
}

class NewsPresenter {
    weak var view: NewsViewProtocol?
    var router: NewsRouterProtocol?
    var interactor: NewsInteractorProtocol?
    
    init(router: NewsRouterProtocol, interactor: NewsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension NewsPresenter: NewsPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchStoredData()
    }
    
    func tableViewStartedLoadingNewData() {
        if interactor?.checkInternetConnectivity() == true {
            if NetworkManager.shared.isFetching {
                // we are already fetching
                return
            }
            interactor?.fetchNewData(page: 1)
        } else {
            view?.showNoInternetAlert()
            return
        }
    }
    
    func fetchMoreData(page: Int, completion: @escaping () -> ()) {
        if interactor?.checkInternetConnectivity() == true {
            if NetworkManager.shared.isFetching {
                // we are already fetching
                return
            }
            interactor?.fetchNewData(page: page)
            completion()
        } else {
            view?.showNoInternetAlert()
            return
        }
    }
    
    func dataFetched(articles: [Article]?) {
        guard let articles = articles else { return }
        view?.showArticles(articles: articles)
    }
    
    func didTapOnCell(with article: Article) {
        interactor?.updateViewsCounter(for: article.url)
        router?.openDetailedInfo(for: article)
    }
    
}
