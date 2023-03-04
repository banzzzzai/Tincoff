//
//  DetailedNewsPresenter.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol DetailedNewsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func dataDidLoad(article: Article)
    func urlButtonClicked(url: String)
}

class DetailedNewsPresenter {
    weak var view: DetailedNewsViewProtocol?
    var router: DetailedNewsRouterProtocol?
    var interactor: DetailedNewsInteractorProtocol?
    
    init(router: DetailedNewsRouterProtocol, interactor: DetailedNewsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension DetailedNewsPresenter: DetailedNewsPresenterProtocol {

    func viewDidLoad() {
        interactor?.loadData()
    }
    
    func dataDidLoad(article: Article) {
        view?.showInfo(article: article)
    }
    
    func urlButtonClicked(url: String) {
        if interactor?.checkInternetConnectivity() == true {
            guard !NetworkManager.shared.isFetching else {
                // we are already fetching
                return
            }
            router?.openWebPage(with: url)
        } else {
            view?.showNoInternetAlert()
            return
        }
    }
    
}
